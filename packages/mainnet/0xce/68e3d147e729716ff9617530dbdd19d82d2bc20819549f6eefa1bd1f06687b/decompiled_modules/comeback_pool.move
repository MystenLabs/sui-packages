module 0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::comeback_pool {
    struct Milestone has copy, drop, store {
        description: vector<u8>,
        completed: bool,
        verified_at: u64,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        participant: address,
        navigator: address,
        crisis_fund: address,
        total_staked: 0x2::balance::Balance<0x2::sui::SUI>,
        stakers: 0x2::table::Table<address, u64>,
        milestones: vector<Milestone>,
        created_at: u64,
        ends_at: u64,
        completed: bool,
    }

    public entry fun complete_pool(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.ends_at, 0);
        assert!(!arg0.completed, 4);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Milestone>(&arg0.milestones)) {
            if (0x1::vector::borrow<Milestone>(&arg0.milestones, v1).completed) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.total_staked);
        if (v0 == 6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_staked, v2 * 75 / 100, arg2), arg0.participant);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_staked, v2 * 5 / 100, arg2), arg0.navigator);
        } else if (v0 >= 3 && v0 <= 5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_staked, v2 * 375 / 1000, arg2), arg0.participant);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_staked, v2 * 5 / 100, arg2), arg0.navigator);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_staked, v2 * 5 / 100, arg2), arg0.navigator);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_staked, v2 * 95 / 100, arg2), arg0.crisis_fund);
        };
        arg0.completed = true;
    }

    public entry fun create_pool(arg0: address, arg1: address, arg2: address, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x1::vector::empty<Milestone>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg3)) {
            let v3 = Milestone{
                description : *0x1::vector::borrow<vector<u8>>(&arg3, v2),
                completed   : false,
                verified_at : 0,
            };
            0x1::vector::push_back<Milestone>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = Pool{
            id           : 0x2::object::new(arg5),
            participant  : arg0,
            navigator    : arg1,
            crisis_fund  : arg2,
            total_staked : 0x2::balance::zero<0x2::sui::SUI>(),
            stakers      : 0x2::table::new<address, u64>(arg5),
            milestones   : v1,
            created_at   : v0,
            ends_at      : v0 + 7776000000,
            completed    : false,
        };
        0x2::transfer::share_object<Pool>(v4);
    }

    public entry fun stake(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_staked, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (0x2::table::contains<address, u64>(&arg0.stakers, v0)) {
            0x2::table::add<address, u64>(&mut arg0.stakers, v0, 0x2::table::remove<address, u64>(&mut arg0.stakers, v0) + 0x2::coin::value<0x2::sui::SUI>(&arg1));
        } else {
            0x2::table::add<address, u64>(&mut arg0.stakers, v0, 0x2::coin::value<0x2::sui::SUI>(&arg1));
        };
    }

    public entry fun verify_milestone(arg0: &mut Pool, arg1: u64, arg2: 0x2::coin::Coin<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>, arg3: &mut 0x2::coin::TreasuryCap<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>, arg4: &mut 0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::verification_fees::Treasury, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.navigator, 2);
        assert!(arg1 < 0x1::vector::length<Milestone>(&arg0.milestones), 3);
        0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::verification_fees::collect_fee(arg4, arg3, arg2, arg6);
        let v0 = 0x1::vector::borrow_mut<Milestone>(&mut arg0.milestones, arg1);
        v0.completed = true;
        v0.verified_at = 0x2::clock::timestamp_ms(arg5);
    }

    // decompiled from Move bytecode v6
}

