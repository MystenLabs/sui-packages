module 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2 {
    struct Launchpad<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        minted_count: u64,
        max_count: u64,
        allow_count: u64,
        price: u64,
        is_whitelist: bool,
        claimed: 0x2::vec_map::VecMap<address, u64>,
        balance: 0x2::coin::Coin<T1>,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        num: u64,
    }

    public entry fun adjust_price<T0: store + key, T1>(arg0: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::Slingshot, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_mut_launchpad<Launchpad<T0, T1>>(arg0, arg1);
        assert!(0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_admin(arg0) == 0x2::tx_context::sender(arg4), 5);
        assert!(v0.start_time > 0x2::clock::timestamp_ms(arg2), 2);
        v0.price = arg3;
    }

    public entry fun create_multi_sales_launchpad<T0: store + key, T1>(arg0: &0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::LaunchpadCap<Launchpad<T0, T1>>, arg1: address, arg2: vector<bool>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<Launchpad<T0, T1>>();
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::vector::length<u64>(&arg7) > 0) {
            let v2 = Launchpad<T0, T1>{
                id           : 0x2::object::new(arg8),
                start_time   : 0x1::vector::pop_back<u64>(&mut arg4),
                end_time     : 0x1::vector::pop_back<u64>(&mut arg5),
                minted_count : 0,
                max_count    : 0x1::vector::pop_back<u64>(&mut arg3),
                allow_count  : 0x1::vector::pop_back<u64>(&mut arg6),
                price        : 0x1::vector::pop_back<u64>(&mut arg7),
                is_whitelist : 0x1::vector::pop_back<bool>(&mut arg2),
                claimed      : 0x2::vec_map::empty<address, u64>(),
                balance      : 0x2::coin::zero<T1>(arg8),
            };
            0x1::vector::push_back<Launchpad<T0, T1>>(&mut v0, v2);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<Launchpad<T0, T1>>(&v2));
        };
        let (v3, v4) = 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::create_slingshot<Launchpad<T0, T1>>(arg0, arg1, true, v0, arg8);
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_event::slingshot_create_event(v3, arg1, true, v4, v1);
    }

    public entry fun create_whitelist<T0: store + key, T1>(arg0: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::Slingshot, arg1: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_whitelist::ActivityList, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_admin(arg0) == 0x2::tx_context::sender(arg5), 5);
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_whitelist::create_activity(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun delete_mint_cap<T0>(arg0: MintCap<T0>) {
        let MintCap {
            id  : v0,
            num : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint_cap_inner_num<T0: store + key>(arg0: &MintCap<T0>) : u64 {
        arg0.num
    }

    public entry fun modify_whitelist<T0: store + key, T1>(arg0: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::Slingshot, arg1: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_whitelist::Activity, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_admin(arg0) == 0x2::tx_context::sender(arg4), 5);
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_whitelist::modify_activity(arg1, arg2, arg3);
    }

    fun purchase<T0: store + key, T1>(arg0: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::Slingshot, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut MintCap<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_live(arg0), 7);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_mut_launchpad<Launchpad<T0, T1>>(arg0, arg1);
        assert!(0x2::coin::value<T1>(arg3) == v1.price, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.start_time, 2);
        assert!(0x2::clock::timestamp_ms(arg2) <= v1.end_time, 2);
        assert!(v1.minted_count < v1.max_count, 3);
        let v2 = v1.price * 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_market_fee(arg0) / 100;
        if (v2 > 0) {
            0x2::pay::split_and_transfer<T1>(arg3, v2, 0x2::tx_context::sender(arg5), arg5);
        };
        if (0x2::vec_map::contains<address, u64>(&v1.claimed, &v0) == true) {
            let (_, v4) = 0x2::vec_map::remove<address, u64>(&mut v1.claimed, &v0);
            assert!(v4 < v1.allow_count, 3);
            0x2::vec_map::insert<address, u64>(&mut v1.claimed, v0, v4 + 1);
        } else {
            0x2::vec_map::insert<address, u64>(&mut v1.claimed, v0, 1);
        };
        v1.minted_count = v1.minted_count + 1;
        0x2::pay::join<T1>(&mut v1.balance, 0x2::coin::split<T1>(arg3, v1.price - v2, arg5));
        arg4.num = arg4.num + 1;
    }

    public fun purchase_with_whitelist<T0: store + key, T1>(arg0: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::Slingshot, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_whitelist::Activity, arg5: vector<vector<u8>>, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) : MintCap<T0> {
        assert!(0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_launchpad<Launchpad<T0, T1>>(arg0, arg1).is_whitelist, 6);
        assert!(0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_whitelist::check_whitelist(arg4, arg5, arg7), 6);
        let v0 = MintCap<T0>{
            id  : 0x2::object::new(arg7),
            num : 0,
        };
        while (arg2 > 0) {
            let v1 = &mut v0;
            purchase<T0, T1>(arg0, arg1, arg3, arg6, v1, arg7);
            arg2 = arg2 - 1;
        };
        v0
    }

    public fun purchase_without_whitelist<T0: store + key, T1>(arg0: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::Slingshot, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : MintCap<T0> {
        assert!(!0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_launchpad<Launchpad<T0, T1>>(arg0, arg1).is_whitelist, 6);
        let v0 = MintCap<T0>{
            id  : 0x2::object::new(arg5),
            num : 0,
        };
        while (arg2 > 0) {
            let v1 = &mut v0;
            purchase<T0, T1>(arg0, arg1, arg3, arg4, v1, arg5);
            arg2 = arg2 - 1;
        };
        v0
    }

    public entry fun remove_launchpads<T0: store + key, T1>(arg0: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::Slingshot, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_admin(arg0) == 0x2::tx_context::sender(arg3), 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v1 = 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::remove_launchpad<Launchpad<T0, T1>>(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1));
            assert!(v1.start_time > 0x2::clock::timestamp_ms(arg2), 0);
            0x2::transfer::public_transfer<Launchpad<T0, T1>>(v1, 0x2::tx_context::sender(arg3));
            v0 = v0 + 1;
        };
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_event::sale_remove_event(0x2::object::id<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::Slingshot>(arg0), arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun update_whitelist_status<T0: store + key, T1>(arg0: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::Slingshot, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_admin(arg0) == 0x2::tx_context::sender(arg3), 5);
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_mut_launchpad<Launchpad<T0, T1>>(arg0, arg1).is_whitelist = arg2;
    }

    public entry fun withdraw<T0: store + key, T1>(arg0: &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::Slingshot, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_admin(arg0) == 0x2::tx_context::sender(arg3), 5);
        let v0 = 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot::borrow_mut_launchpad<Launchpad<T0, T1>>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0.balance, 0x2::coin::value<T1>(&v0.balance), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

