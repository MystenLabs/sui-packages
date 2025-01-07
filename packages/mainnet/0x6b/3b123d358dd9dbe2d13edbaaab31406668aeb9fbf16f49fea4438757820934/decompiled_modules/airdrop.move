module 0x924f12c4a5e78538abe8d64202c1ccfb39c79119782df49050063a9770d37bff::airdrop {
    struct AIRDROP has drop {
        dummy_field: bool,
    }

    struct Airdrops has store, key {
        id: 0x2::object::UID,
        owner_list: vector<address>,
    }

    struct UserAirdrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        user: address,
        quantity: u64,
        is_claim: bool,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        total_amount: u64,
        claimed_amount: u64,
        start_time: u64,
        owner: address,
        reward: 0x2::balance::Balance<T0>,
        allocations: 0x2::object_table::ObjectTable<address, UserAirdrop<T0>>,
        participants: u64,
    }

    public entry fun add_whitelist<T0>(arg0: &mut Pool<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) < arg0.start_time, 5);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 0);
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 4);
        assert!(0x2::coin::value<T0>(&arg4) >= arg3, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            let v2 = UserAirdrop<T0>{
                id       : 0x2::object::new(arg6),
                user     : v1,
                quantity : 0x1::vector::pop_back<u64>(&mut arg2),
                is_claim : false,
            };
            0x2::object_table::add<address, UserAirdrop<T0>>(&mut arg0.allocations, v1, v2);
            v0 = v0 + 1;
        };
        0x2::balance::join<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, arg3, arg6)));
        arg0.total_amount = arg0.total_amount + arg3;
        if (0x2::coin::value<T0>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
    }

    public entry fun claim<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_time, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::object_table::contains<address, UserAirdrop<T0>>(&arg0.allocations, v0), 2);
        let v1 = 0x2::object_table::borrow_mut<address, UserAirdrop<T0>>(&mut arg0.allocations, v0);
        assert!(v1.is_claim == false, 3);
        let v2 = v1.quantity;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reward, v2, arg2), v0);
        arg0.claimed_amount = arg0.claimed_amount + v2;
        arg0.participants = arg0.participants + 1;
        v1.is_claim = true;
    }

    public entry fun create_pool<T0>(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg0), 5);
        let v0 = 0x2::tx_context::sender(arg4);
        if (v0 != @0x53d9c96a30ea6a5a963e0bf0df49141a736e25caf471118e1005728d3005d404 || v0 != @0xbd98eff8cb12fbcb269a334137c00c693d704ce878d8e1fed640acedb235254f) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 150000000000, 7);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 150000000000, arg4), @0x53d9c96a30ea6a5a963e0bf0df49141a736e25caf471118e1005728d3005d404);
            if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        };
        let v1 = Pool<T0>{
            id             : 0x2::object::new(arg4),
            title          : 0x1::string::utf8(arg1),
            total_amount   : 0,
            claimed_amount : 0,
            start_time     : arg2,
            owner          : v0,
            reward         : 0x2::balance::zero<T0>(),
            allocations    : 0x2::object_table::new<address, UserAirdrop<T0>>(arg4),
            participants   : 0,
        };
        0x2::transfer::share_object<Pool<T0>>(v1);
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<AIRDROP>(arg0, arg1);
        let v0 = Airdrops{
            id         : 0x2::object::new(arg1),
            owner_list : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<Airdrops>(v0);
    }

    // decompiled from Move bytecode v6
}

