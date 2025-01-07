module 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad {
    struct Launchpad<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        minted_count: u64,
        max_count: u64,
        allow_count: u64,
        price: u64,
        claimed: 0x2::vec_map::VecMap<address, u64>,
        balance: 0x2::coin::Coin<T1>,
    }

    struct SwiftNftLaunchpadManagerCap has store, key {
        id: 0x2::object::UID,
        market_fee: u64,
    }

    public entry fun adjust_price<T0: store + key, T1>(arg0: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_admin<T0, Launchpad<T0, T1>>(arg0) == 0x2::tx_context::sender(arg4), 5);
        assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::get_launchpad<T0, Launchpad<T0, T1>>(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_sales<T0, Launchpad<T0, T1>>(arg0, arg1)).start_time > 0x2::clock::timestamp_ms(arg2), 2);
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::get_mut_market<T0, Launchpad<T0, T1>>(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_mut_sales<T0, Launchpad<T0, T1>>(arg0, arg1)).price = arg3;
    }

    public entry fun create_multi_sales_launchpad<T0: store + key, T1>(arg0: &SwiftNftLaunchpadManagerCap, arg1: address, arg2: bool, arg3: vector<bool>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::Sale<T0, Launchpad<T0, T1>>>();
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::vector::length<u64>(&arg8) > 0) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg5);
            let v3 = 0x1::vector::pop_back<u64>(&mut arg6);
            let v4 = 0x1::vector::pop_back<u64>(&mut arg8);
            let v5 = 0x1::vector::pop_back<bool>(&mut arg3);
            let v6 = Launchpad<T0, T1>{
                id           : 0x2::object::new(arg9),
                start_time   : v2,
                end_time     : v3,
                minted_count : 0,
                max_count    : 0x1::vector::pop_back<u64>(&mut arg4),
                allow_count  : 0x1::vector::pop_back<u64>(&mut arg7),
                price        : v4,
                claimed      : 0x2::vec_map::empty<address, u64>(),
                balance      : 0x2::coin::zero<T1>(arg9),
            };
            let v7 = 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::create_sale<T0, Launchpad<T0, T1>>(v5, v6, arg9);
            let v8 = 0x2::object::id<0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::Sale<T0, Launchpad<T0, T1>>>(&v7);
            0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_event::sale_create_event(v8, 0x2::object::id<Launchpad<T0, T1>>(&v6), v5, v2, v3, v4);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, v8);
            0x1::vector::push_back<0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::Sale<T0, Launchpad<T0, T1>>>(&mut v0, v7);
        };
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_event::slingshot_create_event(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::create_slingshot<T0, Launchpad<T0, T1>>(arg1, arg2, arg0.market_fee, v0, arg9), arg1, arg2, arg0.market_fee, v1);
    }

    public entry fun create_whitelist<T0: store + key, T1>(arg0: &0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_whitelist::ActivityList, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_admin<T0, Launchpad<T0, T1>>(arg0) == 0x2::tx_context::sender(arg5), 5);
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_whitelist::create_activity(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun delist_item<T0: store + key, T1>(arg0: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_admin<T0, Launchpad<T0, T1>>(arg0) == 0x2::tx_context::sender(arg4), 5);
        let v0 = 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_mut_sales<T0, Launchpad<T0, T1>>(arg0, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) < 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::get_mut_market<T0, Launchpad<T0, T1>>(v0).start_time, 2);
        let v1 = 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::delist_item<T0, Launchpad<T0, T1>>(v0, arg3);
        while (0x1::vector::length<T0>(&v1) > 0) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v1), 0x2::tx_context::sender(arg4));
        };
        0x1::vector::destroy_empty<T0>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwiftNftLaunchpadManagerCap{
            id         : 0x2::object::new(arg0),
            market_fee : 5,
        };
        0x2::transfer::public_transfer<SwiftNftLaunchpadManagerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun list_item<T0: store + key, T1>(arg0: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: vector<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_admin<T0, Launchpad<T0, T1>>(arg0) == 0x2::tx_context::sender(arg4), 5);
        let v0 = 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_mut_sales<T0, Launchpad<T0, T1>>(arg0, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) < 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::get_mut_market<T0, Launchpad<T0, T1>>(v0).start_time, 2);
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::list_multi_item<T0, Launchpad<T0, T1>>(v0, arg3);
    }

    public entry fun modify_whitelist<T0: store + key, T1>(arg0: &0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_whitelist::Activity, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_admin<T0, Launchpad<T0, T1>>(arg0) == 0x2::tx_context::sender(arg4), 5);
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_whitelist::modify_activity(arg1, arg2, arg3);
    }

    fun purchase<T0: store + key, T1>(arg0: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_live<T0, Launchpad<T0, T1>>(arg0), 7);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::get_launchpad<T0, Launchpad<T0, T1>>(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_sales<T0, Launchpad<T0, T1>>(arg0, arg1));
        assert!(0x2::coin::value<T1>(arg3) == v1.price, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.start_time, 2);
        assert!(0x2::clock::timestamp_ms(arg2) <= v1.end_time, 2);
        assert!(v1.minted_count < v1.max_count, 3);
        let v2 = v1.price * 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_market_fee<T0, Launchpad<T0, T1>>(arg0) / 100;
        if (v2 > 0) {
            0x2::pay::split_and_transfer<T1>(arg3, v2, 0x2::tx_context::sender(arg4), arg4);
        };
        let v3 = 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_mut_sales<T0, Launchpad<T0, T1>>(arg0, arg1);
        let v4 = 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::get_mut_market<T0, Launchpad<T0, T1>>(v3);
        if (0x2::vec_map::contains<address, u64>(&v4.claimed, &v0) == true) {
            let (_, v6) = 0x2::vec_map::remove<address, u64>(&mut v4.claimed, &v0);
            assert!(v6 < v4.allow_count, 3);
            0x2::vec_map::insert<address, u64>(&mut v4.claimed, v0, v6 + 1);
        } else {
            0x2::vec_map::insert<address, u64>(&mut v4.claimed, v0, 1);
        };
        v4.minted_count = v4.minted_count + 1;
        0x2::pay::join<T1>(&mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::get_mut_market<T0, Launchpad<T0, T1>>(v3).balance, 0x2::coin::split<T1>(arg3, v1.price - v2, arg4));
        0x2::transfer::public_transfer<T0>(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::withdraw<T0, Launchpad<T0, T1>>(v3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun purchase_with_whitelist<T0: store + key, T1>(arg0: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_whitelist::Activity, arg5: vector<vector<u8>>, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::whitelist_status<T0, Launchpad<T0, T1>>(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_sales<T0, Launchpad<T0, T1>>(arg0, arg1)) == true) {
            assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_whitelist::check_whitelist(arg4, arg5, arg7), 6);
        };
        let v0 = 0;
        while (v0 < arg2) {
            purchase<T0, T1>(arg0, arg1, arg3, arg6, arg7);
            v0 = v0 + 1;
        };
    }

    public entry fun purchase_without_whitelist<T0: store + key, T1>(arg0: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::whitelist_status<T0, Launchpad<T0, T1>>(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_sales<T0, Launchpad<T0, T1>>(arg0, arg1)), 6);
        let v0 = 0;
        while (v0 < arg2) {
            purchase<T0, T1>(arg0, arg1, arg3, arg4, arg5);
            v0 = v0 + 1;
        };
    }

    public entry fun remove_sale<T0: store + key, T1>(arg0: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_admin<T0, Launchpad<T0, T1>>(arg0) == 0x2::tx_context::sender(arg3), 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::get_mut_market<T0, Launchpad<T0, T1>>(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_mut_sales<T0, Launchpad<T0, T1>>(arg0, v1)).start_time > 0x2::clock::timestamp_ms(arg2), 0);
            0x2::transfer::public_transfer<0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::Sale<T0, Launchpad<T0, T1>>>(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::remove_sales<T0, Launchpad<T0, T1>>(arg0, v1), 0x2::tx_context::sender(arg3));
            v0 = v0 + 1;
        };
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_event::sale_remove_event(0x2::object::id<0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>>(arg0), arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun send_manager(arg0: SwiftNftLaunchpadManagerCap, arg1: address) {
        0x2::transfer::public_transfer<SwiftNftLaunchpadManagerCap>(arg0, arg1);
    }

    public entry fun update_whitelist_status<T0: store + key, T1>(arg0: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_admin<T0, Launchpad<T0, T1>>(arg0) == 0x2::tx_context::sender(arg3), 5);
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::modify_whitelist_status<T0, Launchpad<T0, T1>>(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_mut_sales<T0, Launchpad<T0, T1>>(arg0, arg1), arg2);
    }

    public entry fun withdraw<T0: store + key, T1>(arg0: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::Slingshot<T0, Launchpad<T0, T1>>, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_admin<T0, Launchpad<T0, T1>>(arg0) == 0x2::tx_context::sender(arg3), 5);
        let v0 = 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_sale::get_mut_market<T0, Launchpad<T0, T1>>(0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::launchpad_slingshot::borrow_mut_sales<T0, Launchpad<T0, T1>>(arg0, arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0.balance, 0x2::coin::value<T1>(&v0.balance), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

