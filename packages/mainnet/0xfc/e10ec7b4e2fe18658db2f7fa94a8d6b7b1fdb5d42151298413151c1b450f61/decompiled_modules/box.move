module 0xfce10ec7b4e2fe18658db2f7fa94a8d6b7b1fdb5d42151298413151c1b450f61::box {
    struct App has key {
        id: 0x2::object::UID,
        events: 0x2::table_vec::TableVec<BoxEvent>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        ocean_balance: 0x2::balance::Balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>,
        operator_pk: vector<u8>,
        version: u8,
    }

    struct BoxEvent has store {
        boxes: 0x2::table_vec::TableVec<Box>,
        start_time: u64,
        end_time: u64,
    }

    struct Box has store {
        payment_type: u8,
        max_buy: u64,
        price: u64,
        total_sell: u64,
        sold: u64,
        enable: bool,
    }

    struct BuyBox has copy, drop, store {
        buyer: address,
        event_id: u64,
        box_id: u64,
        price: u64,
        payment_type: u8,
    }

    struct SuiClaimed has copy, drop, store {
        receiver: address,
        id: u64,
        amount: u64,
    }

    struct NftClaimed has copy, drop, store {
        receiver: address,
        id: u64,
    }

    struct User has store {
        bought_amount: u64,
    }

    struct BoxOwnerCap has key {
        id: 0x2::object::UID,
    }

    public fun authorize_nft(arg0: &0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NftOwnerCap, arg1: &mut App) {
        0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::authorize_app(arg0, &mut arg1.id, 0);
    }

    entry fun buy_box_ocean(arg0: &mut App, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 9);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::to_bytes<address>(&v0);
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg1));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.operator_pk, &v1) == true, 6);
        assert!(arg1 < 0x2::table_vec::length<BoxEvent>(&arg0.events), 3);
        let v4 = 0x2::table_vec::borrow_mut<BoxEvent>(&mut arg0.events, arg1);
        let v5 = 0x2::clock::timestamp_ms(arg5);
        assert!(v4.start_time == 0 || v5 > v4.start_time, 10);
        assert!(v4.end_time == 0 || v5 < v4.end_time, 11);
        assert!(arg2 < 0x2::table_vec::length<Box>(&v4.boxes), 3);
        let v6 = 0x2::table_vec::borrow_mut<Box>(&mut v4.boxes, arg2);
        assert!(v6.payment_type == 1, 1);
        assert!(v6.enable == true, 12);
        assert!(v6.sold < v6.total_sell, 13);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1)) {
            let v7 = User{bought_amount: 1};
            0x2::dynamic_field::add<vector<u8>, User>(&mut arg0.id, v1, v7);
        } else {
            let v8 = 0x2::dynamic_field::borrow_mut<vector<u8>, User>(&mut arg0.id, v1);
            assert!(v8.bought_amount < v6.max_buy, 4);
            v8.bought_amount = v8.bought_amount + 1;
        };
        let v9 = v6.price;
        v6.sold = v6.sold + 1;
        let v10 = 0x2::coin::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg3);
        assert!(v10 >= v9, 2);
        let v11 = if (v10 > v9) {
            0x2::pay::keep<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg3, arg6);
            0x2::coin::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg3, v9, arg6)
        } else {
            arg3
        };
        0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.ocean_balance, 0x2::coin::into_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(v11));
        let v12 = BuyBox{
            buyer        : v0,
            event_id     : arg1,
            box_id       : arg2,
            price        : v9,
            payment_type : 1,
        };
        0x2::event::emit<BuyBox>(v12);
    }

    entry fun buy_box_sui(arg0: &mut App, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 9);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::to_bytes<address>(&v0);
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg1));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.operator_pk, &v1) == true, 6);
        assert!(arg1 < 0x2::table_vec::length<BoxEvent>(&arg0.events), 3);
        let v4 = 0x2::table_vec::borrow_mut<BoxEvent>(&mut arg0.events, arg1);
        let v5 = 0x2::clock::timestamp_ms(arg5);
        assert!(v4.start_time == 0 || v5 > v4.start_time, 10);
        assert!(v4.end_time == 0 || v5 < v4.end_time, 11);
        assert!(arg2 < 0x2::table_vec::length<Box>(&v4.boxes), 3);
        let v6 = 0x2::table_vec::borrow_mut<Box>(&mut v4.boxes, arg2);
        assert!(v6.payment_type == 0, 1);
        assert!(v6.enable == true, 12);
        assert!(v6.sold < v6.total_sell, 13);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1)) {
            let v7 = User{bought_amount: 1};
            0x2::dynamic_field::add<vector<u8>, User>(&mut arg0.id, v1, v7);
        } else {
            let v8 = 0x2::dynamic_field::borrow_mut<vector<u8>, User>(&mut arg0.id, v1);
            assert!(v8.bought_amount < v6.max_buy, 4);
            v8.bought_amount = v8.bought_amount + 1;
        };
        let v9 = v6.price;
        v6.sold = v6.sold + 1;
        let v10 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v10 >= v9, 2);
        let v11 = if (v10 > v9) {
            0x2::pay::keep<0x2::sui::SUI>(arg3, arg6);
            0x2::coin::split<0x2::sui::SUI>(&mut arg3, v9, arg6)
        } else {
            arg3
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v11));
        let v12 = BuyBox{
            buyer        : v0,
            event_id     : arg1,
            box_id       : arg2,
            price        : v9,
            payment_type : 0,
        };
        0x2::event::emit<BuyBox>(v12);
    }

    entry fun claim_nft(arg0: &mut App, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u16, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 9);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::string::utf8(b"CLAIM_NFT:");
        let v2 = 0x2::bcs::to_bytes<0x1::string::String>(&v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg1));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg2));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg4));
        let v6 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v6));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u16>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0.operator_pk, &v2) == true, 6);
        assert!(!0x2::dynamic_field::exists_<u64>(&arg0.id, arg1), 5);
        0x2::dynamic_field::add<u64, bool>(&mut arg0.id, arg1, true);
        0x2::transfer::public_transfer<0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NFT>(0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::mint(&mut arg0.id, arg2, arg3, arg4, arg5, arg7), v0);
        let v7 = NftClaimed{
            receiver : v0,
            id       : arg1,
        };
        0x2::event::emit<NftClaimed>(v7);
    }

    entry fun claim_sui(arg0: &mut App, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 9);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::string::utf8(b"CLAIM_SUI:");
        let v2 = 0x2::bcs::to_bytes<0x1::string::String>(&v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg1));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.operator_pk, &v2) == true, 6);
        assert!(!0x2::dynamic_field::exists_<u64>(&arg0.id, arg1), 5);
        0x2::dynamic_field::add<u64, bool>(&mut arg0.id, arg1, true);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        assert!(v4 >= arg2, 7);
        if (v4 > arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2), arg4), v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), arg4), v0);
        };
        let v5 = SuiClaimed{
            receiver : v0,
            id       : arg1,
            amount   : arg2,
        };
        0x2::event::emit<SuiClaimed>(v5);
    }

    entry fun deposit_sui(arg0: &mut App, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v1 = App{
            id            : 0x2::object::new(arg0),
            events        : 0x2::table_vec::empty<BoxEvent>(arg0),
            sui_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            ocean_balance : 0x2::balance::zero<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(),
            operator_pk   : 0x2::bcs::to_bytes<address>(&v0),
            version       : 1,
        };
        0x2::transfer::share_object<App>(v1);
        let v2 = BoxOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BoxOwnerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &BoxOwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 8);
        arg1.version = 1;
    }

    entry fun update_boxes(arg0: &BoxOwnerCap, arg1: &mut App, arg2: u64, arg3: vector<u64>, arg4: vector<u8>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<bool>) {
        assert!(arg2 < 0x2::table_vec::length<BoxEvent>(&arg1.events), 3);
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == 0x1::vector::length<u8>(&arg4) && v0 == 0x1::vector::length<u64>(&arg6) && v0 == 0x1::vector::length<u64>(&arg5) && v0 == 0x1::vector::length<u64>(&arg7) && v0 == 0x1::vector::length<bool>(&arg8), 3);
        let v1 = 0;
        let v2 = 0x2::table_vec::borrow_mut<BoxEvent>(&mut arg1.events, arg2);
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            if (v3 < 0x2::table_vec::length<Box>(&v2.boxes)) {
                let v4 = 0x2::table_vec::borrow_mut<Box>(&mut v2.boxes, v3);
                v4.price = *0x1::vector::borrow<u64>(&arg6, v1);
                v4.payment_type = *0x1::vector::borrow<u8>(&arg4, v1);
                v4.total_sell = *0x1::vector::borrow<u64>(&arg7, v1);
                v4.max_buy = *0x1::vector::borrow<u64>(&arg5, v1);
                v4.enable = *0x1::vector::borrow<bool>(&arg8, v1);
            } else {
                let v5 = Box{
                    payment_type : *0x1::vector::borrow<u8>(&arg4, v1),
                    max_buy      : *0x1::vector::borrow<u64>(&arg5, v1),
                    price        : *0x1::vector::borrow<u64>(&arg6, v1),
                    total_sell   : *0x1::vector::borrow<u64>(&arg7, v1),
                    sold         : 0,
                    enable       : *0x1::vector::borrow<bool>(&arg8, v1),
                };
                0x2::table_vec::push_back<Box>(&mut v2.boxes, v5);
            };
            v1 = v1 + 1;
        };
    }

    entry fun update_events(arg0: &BoxOwnerCap, arg1: &mut App, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3) && v0 == 0x1::vector::length<u64>(&arg4), 3);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            if (v2 < 0x2::table_vec::length<BoxEvent>(&arg1.events)) {
                let v3 = 0x2::table_vec::borrow_mut<BoxEvent>(&mut arg1.events, v2);
                v3.start_time = *0x1::vector::borrow<u64>(&arg3, v1);
                v3.end_time = *0x1::vector::borrow<u64>(&arg4, v1);
            } else {
                let v4 = BoxEvent{
                    boxes      : 0x2::table_vec::empty<Box>(arg5),
                    start_time : *0x1::vector::borrow<u64>(&arg3, v1),
                    end_time   : *0x1::vector::borrow<u64>(&arg4, v1),
                };
                0x2::table_vec::push_back<BoxEvent>(&mut arg1.events, v4);
            };
            v1 = v1 + 1;
        };
    }

    entry fun update_operator(arg0: &BoxOwnerCap, arg1: &mut App, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    entry fun withdraw_ocean(arg0: &BoxOwnerCap, arg1: &mut App, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg1.ocean_balance);
        assert!(v0 >= arg2, 7);
        if (v0 > arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg1.ocean_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::withdraw_all<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg1.ocean_balance), arg3), 0x2::tx_context::sender(arg3));
        };
    }

    entry fun withdraw_sui(arg0: &BoxOwnerCap, arg1: &mut App, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance);
        assert!(v0 >= arg2, 7);
        if (v0 > arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_balance), arg3), 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

