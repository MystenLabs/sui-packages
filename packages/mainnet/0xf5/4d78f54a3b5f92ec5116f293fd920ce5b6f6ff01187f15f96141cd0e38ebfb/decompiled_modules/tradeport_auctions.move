module 0xf54d78f54a3b5f92ec5116f293fd920ce5b6f6ff01187f15f96141cd0e38ebfb::tradeport_auctions {
    struct TRADEPORT_AUCTIONS has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        operator: address,
        fee_bps: u64,
        beneficiary: address,
        configs: 0x2::table::Table<0x1::ascii::String, Config>,
        royalties: 0x2::bag::Bag,
        auctions: 0x2::object_table::ObjectTable<0x1::ascii::String, Auction>,
    }

    struct RoyaltyKey<phantom T0, phantom T1> has copy, drop, store {
        policy_id: 0x2::object::ID,
    }

    struct Config has copy, drop, store {
        starting_price: u64,
        duration: u64,
        increment: u64,
        allowed_coins: vector<0x1::ascii::String>,
        paused: bool,
    }

    struct Auction has store, key {
        id: 0x2::object::UID,
        nft_type: 0x1::ascii::String,
        queue: vector<0x2::object::ID>,
        maybe_started_at: 0x1::option::Option<u64>,
        maybe_ends_at: 0x1::option::Option<u64>,
        maybe_top_bidder: 0x1::option::Option<address>,
        top_price: u64,
        top_royalty: u64,
        top_fee: u64,
    }

    struct Lot has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        starting_price: u64,
        submitted_at: u64,
    }

    struct ConfigureAuctionEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        starting_price: u64,
        duration: u64,
        increment: u64,
        allowed_coins: vector<0x1::ascii::String>,
    }

    struct PauseAuctionEvent has copy, drop {
        nft_type: 0x1::ascii::String,
    }

    struct ResumeAuctionEvent has copy, drop {
        nft_type: 0x1::ascii::String,
    }

    struct SubmitLotEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        lot_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        starting_price: u64,
        submitted_at: u64,
        position: u64,
    }

    struct WithdrawLotEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        lot_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
    }

    struct LiveLotEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        lot_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        starting_price: u64,
        started_at: u64,
        ends_at: u64,
    }

    struct PlaceTopBidEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        lot_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        top_bidder: address,
        price: u64,
        royalty: u64,
        fee: u64,
    }

    struct SoldLotEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        lot_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        top_bidder: address,
        price: u64,
        royalty: u64,
        fee: u64,
    }

    struct ReturnLotEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        lot_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        maybe_top_bidder: 0x1::option::Option<address>,
    }

    entry fun create_auction<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: u64, arg3: u64, arg4: vector<0x1::ascii::String>, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg6);
        assert!(arg2 > 0, 14);
        assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg5), 13);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg5)) {
            assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg5, 0) == 0, 13);
        };
        let v0 = type_key<T0>();
        assert!(!0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 3);
        let v1 = Config{
            starting_price : arg1,
            duration       : arg2,
            increment      : arg3,
            allowed_coins  : arg4,
            paused         : false,
        };
        0x2::table::add<0x1::ascii::String, Config>(&mut arg0.configs, v0, v1);
        let v2 = Auction{
            id               : 0x2::object::new(arg6),
            nft_type         : v0,
            queue            : 0x1::vector::empty<0x2::object::ID>(),
            maybe_started_at : 0x1::option::none<u64>(),
            maybe_ends_at    : 0x1::option::none<u64>(),
            maybe_top_bidder : 0x1::option::none<address>(),
            top_price        : 0,
            top_royalty      : 0,
            top_fee          : 0,
        };
        0x2::object_table::add<0x1::ascii::String, Auction>(&mut arg0.auctions, v0, v2);
        let v3 = ConfigureAuctionEvent{
            nft_type       : v0,
            starting_price : arg1,
            duration       : arg2,
            increment      : arg3,
            allowed_coins  : arg4,
        };
        0x2::event::emit<ConfigureAuctionEvent>(v3);
    }

    fun init(arg0: TRADEPORT_AUCTIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id          : 0x2::object::new(arg1),
            version     : 1,
            admin       : 0x2::tx_context::sender(arg1),
            operator    : 0x2::tx_context::sender(arg1),
            fee_bps     : 300,
            beneficiary : 0x2::tx_context::sender(arg1),
            configs     : 0x2::table::new<0x1::ascii::String, Config>(arg1),
            royalties   : 0x2::bag::new(arg1),
            auctions    : 0x2::object_table::new<0x1::ascii::String, Auction>(arg1),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    entry fun pause<T0: store + key>(arg0: &mut Store, arg1: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg1);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        0x2::table::borrow_mut<0x1::ascii::String, Config>(&mut arg0.configs, v0).paused = true;
        let v1 = PauseAuctionEvent{nft_type: v0};
        0x2::event::emit<PauseAuctionEvent>(v1);
    }

    entry fun place_bid<T0: store + key, T1>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        let v1 = type_key<T1>();
        let v2 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        assert!(0x1::option::is_some<u64>(&v2.maybe_started_at), 8);
        assert!(0x2::clock::timestamp_ms(arg5) < *0x1::option::borrow<u64>(&v2.maybe_ends_at), 9);
        assert!(*0x1::vector::borrow<0x2::object::ID>(&v2.queue, 0) == arg1, 15);
        let v3 = v2.top_price;
        let v4 = if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg4)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg4, arg2)
        } else {
            0
        };
        let v5 = (((arg2 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        assert!(0x2::coin::value<T1>(&arg3) == arg2 + v4 + v5, 16);
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lot>(&mut v2.id, arg1);
        assert!(v6.coin_type == v1, 18);
        let v7 = 0x2::object::id<Lot>(v6);
        if (v3 == 0) {
            assert!(arg2 >= v6.starting_price, 7);
            0x2::dynamic_field::add<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v6.id, v7, 0x2::coin::into_balance<T1>(arg3));
        } else {
            assert!(arg2 >= v3 + 0x2::table::borrow<0x1::ascii::String, Config>(&arg0.configs, v0).increment, 7);
            let v8 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v6.id, v7);
            0x2::balance::send_funds<T1>(0x2::balance::withdraw_all<T1>(v8), *0x1::option::borrow<address>(&v2.maybe_top_bidder));
            0x2::balance::join<T1>(v8, 0x2::coin::into_balance<T1>(arg3));
        };
        let v9 = 0x2::tx_context::sender(arg6);
        v2.top_price = arg2;
        v2.top_royalty = v4;
        v2.top_fee = v5;
        v2.maybe_top_bidder = 0x1::option::some<address>(v9);
        let v10 = PlaceTopBidEvent{
            nft_type   : v0,
            lot_id     : v7,
            nft_id     : arg1,
            coin_type  : v1,
            top_bidder : v9,
            price      : arg2,
            royalty    : v4,
            fee        : v5,
        };
        0x2::event::emit<PlaceTopBidEvent>(v10);
    }

    entry fun resume<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg2);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, Config>(&mut arg0.configs, v0);
        v1.paused = false;
        let v2 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        switch_to_next_lot(v2, 0x2::clock::timestamp_ms(arg1), v1);
        let v3 = ResumeAuctionEvent{nft_type: v0};
        0x2::event::emit<ResumeAuctionEvent>(v3);
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_beneficiary(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.beneficiary = arg1;
    }

    entry fun set_fee_bps(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        assert!(arg1 <= 10000, 14);
        arg0.fee_bps = arg1;
    }

    entry fun set_operator(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.operator = arg1;
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    entry fun settle<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg4);
        let v0 = type_key<T0>();
        assert!(0x2::object_table::contains<0x1::ascii::String, Auction>(&arg0.auctions, v0), 4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        assert!(0x1::option::is_some<u64>(&v2.maybe_started_at), 8);
        assert!(v1 >= *0x1::option::borrow<u64>(&v2.maybe_ends_at), 10);
        let v3 = 0x1::vector::remove<0x2::object::ID>(&mut v2.queue, 0);
        let v4 = v2.top_price;
        let v5 = v2.top_royalty;
        let v6 = v2.top_fee;
        let v7 = v2.maybe_top_bidder;
        let Lot {
            id              : v8,
            nft_id          : _,
            coin_type       : v10,
            seller          : v11,
            seller_kiosk_id : v12,
            starting_price  : _,
            submitted_at    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Lot>(&mut v2.id, v3);
        let v15 = v8;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v12, 12);
        assert!(v10 == type_key<T1>(), 18);
        let v16 = 0x2::object::uid_to_inner(&v15);
        let v17 = if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg2)) {
            let v18 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2) && 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, 0) > 0;
            !v18
        } else {
            false
        };
        if (v4 > 0 && v17) {
            let v19 = *0x1::option::borrow<address>(&v7);
            let (v20, v21) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v15, v3), 0x2::coin::zero<0x2::sui::SUI>(arg4));
            let v22 = v21;
            if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v22, 0x2::coin::zero<0x2::sui::SUI>(arg4));
            };
            let (v23, v24) = 0x2::kiosk::new(arg4);
            let v25 = v24;
            let v26 = v23;
            if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg2)) {
                0x2::kiosk::lock<T0>(&mut v26, &v25, arg2, v20);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v22, &v26);
            } else {
                0x2::kiosk::place<T0>(&mut v26, &v25, v20);
            };
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v26, v25, v19, arg4);
            if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg2)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(&v26, &mut v22);
            };
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v22);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v26);
            let v30 = 0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v15, v16);
            0x2::balance::send_funds<T1>(0x2::balance::split<T1>(&mut v30, v4), v11);
            if (v5 > 0) {
                let v31 = RoyaltyKey<T0, T1>{policy_id: 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg2)};
                if (!0x2::bag::contains<RoyaltyKey<T0, T1>>(&arg0.royalties, v31)) {
                    0x2::bag::add<RoyaltyKey<T0, T1>, 0x2::balance::Balance<T1>>(&mut arg0.royalties, v31, 0x2::balance::zero<T1>());
                };
                0x2::balance::join<T1>(0x2::bag::borrow_mut<RoyaltyKey<T0, T1>, 0x2::balance::Balance<T1>>(&mut arg0.royalties, v31), 0x2::balance::split<T1>(&mut v30, v5));
            };
            if (v6 > 0) {
                0x2::balance::send_funds<T1>(v30, arg0.beneficiary);
            } else {
                0x2::balance::destroy_zero<T1>(v30);
            };
            let v32 = SoldLotEvent{
                nft_type        : v0,
                lot_id          : v16,
                nft_id          : v3,
                coin_type       : v10,
                seller          : v11,
                seller_kiosk_id : v12,
                top_bidder      : v19,
                price           : v4,
                royalty         : v5,
                fee             : v6,
            };
            0x2::event::emit<SoldLotEvent>(v32);
        } else {
            if (v4 > 0) {
                0x2::balance::send_funds<T1>(0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v15, v16), *0x1::option::borrow<address>(&v7));
            };
            0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v15, v3));
            let v33 = ReturnLotEvent{
                nft_type         : v0,
                lot_id           : v16,
                nft_id           : v3,
                coin_type        : v10,
                seller           : v11,
                seller_kiosk_id  : v12,
                maybe_top_bidder : v7,
            };
            0x2::event::emit<ReturnLotEvent>(v33);
        };
        0x2::object::delete(v15);
        v2.maybe_started_at = 0x1::option::none<u64>();
        v2.maybe_ends_at = 0x1::option::none<u64>();
        v2.maybe_top_bidder = 0x1::option::none<address>();
        v2.top_price = 0;
        v2.top_royalty = 0;
        v2.top_fee = 0;
        let v34 = *0x2::table::borrow<0x1::ascii::String, Config>(&arg0.configs, v0);
        switch_to_next_lot(v2, v1, &v34);
    }

    entry fun submit<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        let v1 = *0x2::table::borrow<0x1::ascii::String, Config>(&arg0.configs, v0);
        let v2 = type_key<T1>();
        assert!(0x1::vector::is_empty<0x1::ascii::String>(&v1.allowed_coins) || 0x1::vector::contains<0x1::ascii::String>(&v1.allowed_coins, &v2), 17);
        let v3 = if (v1.starting_price == 0) {
            arg4
        } else {
            v1.starting_price
        };
        assert!(v3 > 0, 6);
        let v4 = 0x2::tx_context::sender(arg6);
        let v5 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v6 = 0x2::clock::timestamp_ms(arg5);
        let v7 = Lot{
            id              : 0x2::object::new(arg6),
            nft_id          : arg3,
            coin_type       : v2,
            seller          : v4,
            seller_kiosk_id : v5,
            starting_price  : v3,
            submitted_at    : v6,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v7.id, arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg6));
        let v8 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Lot>(&mut v8.id, arg3, v7);
        0x1::vector::push_back<0x2::object::ID>(&mut v8.queue, arg3);
        let v9 = SubmitLotEvent{
            nft_type        : v0,
            lot_id          : 0x2::object::id<Lot>(&v7),
            nft_id          : arg3,
            coin_type       : v2,
            seller          : v4,
            seller_kiosk_id : v5,
            starting_price  : v3,
            submitted_at    : v6,
            position        : 0x1::vector::length<0x2::object::ID>(&v8.queue),
        };
        0x2::event::emit<SubmitLotEvent>(v9);
        switch_to_next_lot(v8, v6, &v1);
    }

    fun switch_to_next_lot(arg0: &mut Auction, arg1: u64, arg2: &Config) {
        let v0 = if (!0x1::vector::is_empty<0x2::object::ID>(&arg0.queue)) {
            if (!arg2.paused) {
                0x1::option::is_none<u64>(&arg0.maybe_started_at)
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            let v1 = arg1 + arg2.duration;
            arg0.maybe_started_at = 0x1::option::some<u64>(arg1);
            arg0.maybe_ends_at = 0x1::option::some<u64>(v1);
            arg0.maybe_top_bidder = 0x1::option::none<address>();
            arg0.top_price = 0;
            arg0.top_royalty = 0;
            arg0.top_fee = 0;
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg0.queue, 0);
            let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Lot>(&arg0.id, v2);
            let v4 = LiveLotEvent{
                nft_type        : arg0.nft_type,
                lot_id          : 0x2::object::id<Lot>(v3),
                nft_id          : v2,
                coin_type       : v3.coin_type,
                seller          : v3.seller,
                seller_kiosk_id : v3.seller_kiosk_id,
                starting_price  : v3.starting_price,
                started_at      : arg1,
                ends_at         : v1,
            };
            0x2::event::emit<LiveLotEvent>(v4);
        };
    }

    fun type_key<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x1::type_name::as_string(&v0)
    }

    entry fun update_config<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: u64, arg3: u64, arg4: vector<0x1::ascii::String>, arg5: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg5);
        assert!(arg2 > 0, 14);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, Config>(&mut arg0.configs, v0);
        v1.starting_price = arg1;
        v1.duration = arg2;
        v1.increment = arg3;
        v1.allowed_coins = arg4;
        let v2 = ConfigureAuctionEvent{
            nft_type       : v0,
            starting_price : arg1,
            duration       : arg2,
            increment      : arg3,
            allowed_coins  : arg4,
        };
        0x2::event::emit<ConfigureAuctionEvent>(v2);
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_operator(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1) || arg0.operator == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 1, 1);
    }

    entry fun withdraw<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID) {
        verify_version(arg0);
        assert!(0x2::kiosk::has_access(arg1, arg2), 2);
        let v0 = type_key<T0>();
        assert!(0x2::object_table::contains<0x1::ascii::String, Auction>(&arg0.auctions, v0), 4);
        let v1 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&v1.queue, &arg3);
        assert!(v2, 5);
        let v4 = 0x1::option::is_some<u64>(&v1.maybe_started_at) && v3 == 0;
        assert!(!v4, 11);
        0x1::vector::remove<0x2::object::ID>(&mut v1.queue, v3);
        let Lot {
            id              : v5,
            nft_id          : _,
            coin_type       : v7,
            seller          : v8,
            seller_kiosk_id : v9,
            starting_price  : _,
            submitted_at    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Lot>(&mut v1.id, arg3);
        let v12 = v5;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v9, 12);
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v12, arg3));
        0x2::object::delete(v12);
        let v13 = WithdrawLotEvent{
            nft_type        : v0,
            lot_id          : 0x2::object::uid_to_inner(&v12),
            nft_id          : arg3,
            coin_type       : v7,
            seller          : v8,
            seller_kiosk_id : v9,
        };
        0x2::event::emit<WithdrawLotEvent>(v13);
    }

    entry fun withdraw_royalties<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &0x2::transfer_policy::TransferPolicyCap<T0>, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        0x2::transfer_policy::uid_mut_as_owner<T0>(arg1, arg2);
        let v0 = RoyaltyKey<T0, T1>{policy_id: 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg1)};
        assert!(0x2::bag::contains<RoyaltyKey<T0, T1>>(&arg0.royalties, v0), 19);
        0x2::balance::send_funds<T1>(0x2::bag::remove<RoyaltyKey<T0, T1>, 0x2::balance::Balance<T1>>(&mut arg0.royalties, v0), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

