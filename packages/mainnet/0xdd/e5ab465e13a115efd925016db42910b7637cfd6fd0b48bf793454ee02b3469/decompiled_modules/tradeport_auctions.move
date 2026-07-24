module 0xdc6504aeaaca4f893bd242c369b617a66192559ecf138ce69de597723ed985cf::tradeport_auctions {
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

    struct DurationKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Config has copy, drop, store {
        starting_price: u64,
        duration: u64,
        extension: u64,
        increment: u64,
        increment_bps: u64,
        allowed_coins: vector<0x1::ascii::String>,
        paused: bool,
        paused_until: u64,
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
        extended: bool,
    }

    struct Lot has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        starting_price: u64,
        settle_price: u64,
        buyout_price: u64,
        should_resubmit: bool,
    }

    struct ConfigureAuctionEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        starting_price: u64,
        duration: u64,
        extension: u64,
        increment: u64,
        increment_bps: u64,
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
        settle_price: u64,
        buyout_price: u64,
        should_resubmit: bool,
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

    struct UpdateLotEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        lot_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
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
        ends_at: u64,
        extended: bool,
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

    struct ResubmitLotEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        lot_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        submitted_at: u64,
        position: u64,
    }

    entry fun create_auction<T0: store + key>(arg0: &mut Store, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<0x1::ascii::String>, arg8: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg8);
        assert!(arg3 > 0, 14);
        assert!(arg5 > 0, 14);
        assert!(arg6 <= 10000, 14);
        assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg1), 13);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg1)) {
            assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg1, 0) == 0, 13);
        };
        let v0 = type_key<T0>();
        assert!(!0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 3);
        let v1 = Config{
            starting_price : arg2,
            duration       : arg3,
            extension      : arg4,
            increment      : arg5,
            increment_bps  : arg6,
            allowed_coins  : arg7,
            paused         : false,
            paused_until   : 0,
        };
        0x2::table::add<0x1::ascii::String, Config>(&mut arg0.configs, v0, v1);
        let v2 = Auction{
            id               : 0x2::object::new(arg8),
            nft_type         : v0,
            queue            : 0x1::vector::empty<0x2::object::ID>(),
            maybe_started_at : 0x1::option::none<u64>(),
            maybe_ends_at    : 0x1::option::none<u64>(),
            maybe_top_bidder : 0x1::option::none<address>(),
            top_price        : 0,
            top_royalty      : 0,
            top_fee          : 0,
            extended         : false,
        };
        0x2::object_table::add<0x1::ascii::String, Auction>(&mut arg0.auctions, v0, v2);
        let v3 = ConfigureAuctionEvent{
            nft_type       : v0,
            starting_price : arg2,
            duration       : arg3,
            extension      : arg4,
            increment      : arg5,
            increment_bps  : arg6,
            allowed_coins  : arg7,
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
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, Config>(&mut arg0.configs, v0);
        if (!v1.paused) {
            v1.paused = true;
            let v2 = PauseAuctionEvent{nft_type: v0};
            0x2::event::emit<PauseAuctionEvent>(v2);
        };
    }

    entry fun place_bid<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        let v1 = 0x2::table::borrow<0x1::ascii::String, Config>(&arg0.configs, v0);
        assert!(!v1.paused, 20);
        let v2 = v1.increment_bps;
        let v3 = v1.extension;
        let v4 = type_key<T1>();
        let v5 = 0x2::clock::timestamp_ms(arg6);
        let v6 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        assert!(0x1::option::is_some<u64>(&v6.maybe_started_at), 8);
        assert!(v5 < *0x1::option::borrow<u64>(&v6.maybe_ends_at), 9);
        assert!(*0x1::vector::borrow<0x2::object::ID>(&v6.queue, 0) == arg3, 15);
        let v7 = v6.top_price;
        let v8 = v6.extended;
        let v9 = if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, arg4)
        } else {
            0
        };
        let v10 = (((arg4 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        assert!(0x2::coin::value<T1>(&arg5) == arg4 + v9 + v10, 16);
        let v11 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lot>(&mut v6.id, arg3);
        assert!(v11.coin_type == v4, 18);
        let v12 = 0x2::object::id<Lot>(v11);
        let v13 = v11.buyout_price;
        let v14 = v13 > 0 && arg4 >= v13;
        if (v14) {
            let v15 = if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg2)) {
                let v16 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2) && 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, 0) > 0;
                !v16
            } else {
                false
            };
            assert!(v15, 13);
        };
        if (v7 == 0) {
            assert!(arg4 >= v11.starting_price, 7);
            0x2::dynamic_field::add<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v11.id, v12, 0x2::coin::into_balance<T1>(arg5));
        } else {
            if (!v14) {
                let v17 = if (v8 && v2 > 0) {
                    if (v7 >= 10000) {
                        (((v7 as u128) * (v2 as u128) / (10000 as u128)) as u64)
                    } else {
                        10000
                    }
                } else {
                    v1.increment
                };
                assert!(arg4 >= v7 + v17, 7);
            };
            let v18 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v11.id, v12);
            0x2::balance::send_funds<T1>(0x2::balance::withdraw_all<T1>(v18), *0x1::option::borrow<address>(&v6.maybe_top_bidder));
            0x2::balance::join<T1>(v18, 0x2::coin::into_balance<T1>(arg5));
        };
        let v19 = 0x2::tx_context::sender(arg7);
        v6.top_price = arg4;
        v6.top_royalty = v9;
        v6.top_fee = v10;
        v6.maybe_top_bidder = 0x1::option::some<address>(v19);
        let v20 = *0x1::option::borrow<u64>(&v6.maybe_ends_at);
        let v21 = v20;
        if (v14) {
            v21 = v5;
        } else if (v3 > 0 && v20 - v5 <= v3) {
            let v22 = v5 + v3;
            v21 = v22;
            v6.maybe_ends_at = 0x1::option::some<u64>(v22);
            v6.extended = true;
        };
        let v23 = PlaceTopBidEvent{
            nft_type   : v0,
            lot_id     : v12,
            nft_id     : arg3,
            coin_type  : v4,
            top_bidder : v19,
            price      : arg4,
            royalty    : v9,
            fee        : v10,
            ends_at    : v21,
            extended   : v6.extended,
        };
        0x2::event::emit<PlaceTopBidEvent>(v23);
        if (v14) {
            0x1::vector::remove<0x2::object::ID>(&mut v6.queue, 0);
            let v24 = &mut arg0.royalties;
            sell_lot<T0, T1>(arg1, arg2, v24, 0x2::dynamic_object_field::remove<0x2::object::ID, Lot>(&mut v6.id, arg3), v0, v19, arg4, v9, v10, arg0.beneficiary, arg7);
            reset_auction(v6);
            let v25 = *0x2::table::borrow<0x1::ascii::String, Config>(&arg0.configs, v0);
            switch_to_next_lot(v6, v5, &v25);
        };
    }

    fun remove_duration(arg0: &mut 0x2::object::UID) {
        let v0 = DurationKey{dummy_field: false};
        if (0x2::dynamic_field::exists<DurationKey>(arg0, v0)) {
            let v1 = DurationKey{dummy_field: false};
            0x2::dynamic_field::remove<DurationKey, u64>(arg0, v1);
        };
    }

    fun reset_auction(arg0: &mut Auction) {
        arg0.maybe_started_at = 0x1::option::none<u64>();
        arg0.maybe_ends_at = 0x1::option::none<u64>();
        arg0.maybe_top_bidder = 0x1::option::none<address>();
        arg0.top_price = 0;
        arg0.top_royalty = 0;
        arg0.top_fee = 0;
        arg0.extended = false;
    }

    entry fun resume<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg2);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, Config>(&mut arg0.configs, v0);
        if (v1.paused) {
            v1.paused = false;
            let v2 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
            switch_to_next_lot(v2, 0x2::clock::timestamp_ms(arg1), v1);
            let v3 = ResumeAuctionEvent{nft_type: v0};
            0x2::event::emit<ResumeAuctionEvent>(v3);
        };
    }

    fun sell_lot<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::bag::Bag, arg3: Lot, arg4: 0x1::ascii::String, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        let Lot {
            id              : v0,
            nft_id          : v1,
            coin_type       : v2,
            seller          : v3,
            seller_kiosk_id : v4,
            starting_price  : _,
            settle_price    : _,
            buyout_price    : _,
            should_resubmit : _,
        } = arg3;
        let v9 = v0;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == v4, 12);
        assert!(v2 == type_key<T1>(), 18);
        let v10 = 0x2::object::uid_to_inner(&v9);
        let (v11, v12) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v9, v1), 0x2::coin::zero<0x2::sui::SUI>(arg10));
        let v13 = v12;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg1)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg1, &mut v13, 0x2::coin::zero<0x2::sui::SUI>(arg10));
        };
        let (v14, v15) = 0x2::kiosk::new(arg10);
        let v16 = v15;
        let v17 = v14;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg1)) {
            0x2::kiosk::lock<T0>(&mut v17, &v16, arg1, v11);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v13, &v17);
        } else {
            0x2::kiosk::place<T0>(&mut v17, &v16, v11);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v17, v16, arg5, arg10);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg1)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(&v17, &mut v13);
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v13);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v17);
        let v21 = 0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v9, v10);
        0x2::balance::send_funds<T1>(0x2::balance::split<T1>(&mut v21, arg6), v3);
        if (arg7 > 0) {
            let v22 = RoyaltyKey<T0, T1>{policy_id: 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg1)};
            if (!0x2::bag::contains<RoyaltyKey<T0, T1>>(arg2, v22)) {
                0x2::bag::add<RoyaltyKey<T0, T1>, 0x2::balance::Balance<T1>>(arg2, v22, 0x2::balance::zero<T1>());
            };
            0x2::balance::join<T1>(0x2::bag::borrow_mut<RoyaltyKey<T0, T1>, 0x2::balance::Balance<T1>>(arg2, v22), 0x2::balance::split<T1>(&mut v21, arg7));
        };
        if (arg8 > 0) {
            0x2::balance::send_funds<T1>(v21, arg9);
        } else {
            0x2::balance::destroy_zero<T1>(v21);
        };
        let v23 = SoldLotEvent{
            nft_type        : arg4,
            lot_id          : v10,
            nft_id          : v1,
            coin_type       : v2,
            seller          : v3,
            seller_kiosk_id : v4,
            top_bidder      : arg5,
            price           : arg6,
            royalty         : arg7,
            fee             : arg8,
        };
        0x2::event::emit<SoldLotEvent>(v23);
        let v24 = &mut v9;
        remove_duration(v24);
        0x2::object::delete(v9);
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

    entry fun set_ends_at<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg3);
        let v0 = type_key<T0>();
        assert!(0x2::object_table::contains<0x1::ascii::String, Auction>(&arg0.auctions, v0), 4);
        let v1 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        assert!(0x1::option::is_some<u64>(&v1.maybe_started_at), 8);
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2), 14);
        v1.maybe_ends_at = 0x1::option::some<u64>(arg1);
        let v2 = *0x1::vector::borrow<0x2::object::ID>(&v1.queue, 0);
        let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Lot>(&v1.id, v2);
        let v4 = UpdateLotEvent{
            nft_type  : v0,
            lot_id    : 0x2::object::id<Lot>(v3),
            nft_id    : v2,
            coin_type : v3.coin_type,
            ends_at   : arg1,
        };
        0x2::event::emit<UpdateLotEvent>(v4);
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
        if (arg0.operator == 0x2::tx_context::sender(arg4)) {
            assert!(v1 >= *0x1::option::borrow<u64>(&v2.maybe_ends_at), 10);
        };
        let v3 = 0x1::vector::remove<0x2::object::ID>(&mut v2.queue, 0);
        let v4 = v2.top_price;
        let v5 = v2.top_fee;
        let v6 = v2.maybe_top_bidder;
        let v7 = 0x2::dynamic_object_field::remove<0x2::object::ID, Lot>(&mut v2.id, v3);
        let v8 = if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg2)) {
            let v9 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2) && 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, 0) > 0;
            !v9
        } else {
            false
        };
        let v10 = if (v4 > 0) {
            if (v4 >= v7.settle_price) {
                v8
            } else {
                false
            }
        } else {
            false
        };
        if (v10) {
            let v11 = &mut arg0.royalties;
            sell_lot<T0, T1>(arg1, arg2, v11, v7, v0, *0x1::option::borrow<address>(&v6), v4, v2.top_royalty, v5, arg0.beneficiary, arg4);
        } else if (v7.should_resubmit) {
            let v12 = 0x2::object::id<Lot>(&v7);
            let v13 = v7.coin_type;
            assert!(v13 == type_key<T1>(), 18);
            if (v4 > 0) {
                0x2::balance::send_funds<T1>(0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v7.id, v12), *0x1::option::borrow<address>(&v6));
            };
            0x2::dynamic_object_field::add<0x2::object::ID, Lot>(&mut v2.id, v3, v7);
            0x1::vector::push_back<0x2::object::ID>(&mut v2.queue, v3);
            let v14 = ResubmitLotEvent{
                nft_type        : v0,
                lot_id          : v12,
                nft_id          : v3,
                coin_type       : v13,
                seller          : v7.seller,
                seller_kiosk_id : v7.seller_kiosk_id,
                submitted_at    : v1,
                position        : 0x1::vector::length<0x2::object::ID>(&v2.queue),
            };
            0x2::event::emit<ResubmitLotEvent>(v14);
        } else {
            let Lot {
                id              : v15,
                nft_id          : _,
                coin_type       : v17,
                seller          : v18,
                seller_kiosk_id : v19,
                starting_price  : _,
                settle_price    : _,
                buyout_price    : _,
                should_resubmit : _,
            } = v7;
            let v24 = v15;
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v19, 12);
            assert!(v17 == type_key<T1>(), 18);
            let v25 = 0x2::object::uid_to_inner(&v24);
            if (v4 > 0) {
                0x2::balance::send_funds<T1>(0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v24, v25), *0x1::option::borrow<address>(&v6));
            };
            0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v24, v3));
            let v26 = &mut v24;
            remove_duration(v26);
            0x2::object::delete(v24);
            let v27 = ReturnLotEvent{
                nft_type         : v0,
                lot_id           : v25,
                nft_id           : v3,
                coin_type        : v17,
                seller           : v18,
                seller_kiosk_id  : v19,
                maybe_top_bidder : v6,
            };
            0x2::event::emit<ReturnLotEvent>(v27);
        };
        reset_auction(v2);
        let v28 = *0x2::table::borrow<0x1::ascii::String, Config>(&arg0.configs, v0);
        switch_to_next_lot(v2, v1, &v28);
    }

    public fun submit<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        submit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0, arg8, arg9);
    }

    fun submit_internal<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        let v1 = *0x2::table::borrow<0x1::ascii::String, Config>(&arg0.configs, v0);
        assert!(!v1.paused, 20);
        let v2 = type_key<T1>();
        assert!(0x1::vector::is_empty<0x1::ascii::String>(&v1.allowed_coins) || 0x1::vector::contains<0x1::ascii::String>(&v1.allowed_coins, &v2), 17);
        let v3 = if (v1.starting_price == 0) {
            arg4
        } else {
            v1.starting_price
        };
        assert!(v3 > 0, 6);
        assert!(arg5 == 0 || arg5 >= v3, 21);
        let v4 = if (arg5 == 0) {
            v3
        } else {
            arg5
        };
        assert!(arg6 == 0 || arg6 >= v4, 21);
        let v5 = 0x2::tx_context::sender(arg10);
        let v6 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v7 = 0x2::clock::timestamp_ms(arg9);
        let v8 = Lot{
            id              : 0x2::object::new(arg10),
            nft_id          : arg3,
            coin_type       : v2,
            seller          : v5,
            seller_kiosk_id : v6,
            starting_price  : v3,
            settle_price    : arg5,
            buyout_price    : arg6,
            should_resubmit : arg7,
        };
        if (arg8 > 0) {
            let v9 = DurationKey{dummy_field: false};
            0x2::dynamic_field::add<DurationKey, u64>(&mut v8.id, v9, arg8);
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v8.id, arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg10));
        let v10 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Lot>(&mut v10.id, arg3, v8);
        0x1::vector::push_back<0x2::object::ID>(&mut v10.queue, arg3);
        let v11 = SubmitLotEvent{
            nft_type        : v0,
            lot_id          : 0x2::object::id<Lot>(&v8),
            nft_id          : arg3,
            coin_type       : v2,
            seller          : v5,
            seller_kiosk_id : v6,
            starting_price  : v3,
            settle_price    : arg5,
            buyout_price    : arg6,
            should_resubmit : arg7,
            submitted_at    : v7,
            position        : 0x1::vector::length<0x2::object::ID>(&v10.queue),
        };
        0x2::event::emit<SubmitLotEvent>(v11);
        switch_to_next_lot(v10, v7, &v1);
    }

    public fun submit_with_duration<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 14);
        submit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
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
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg0.queue, 0);
            let v2 = arg2.duration;
            let v3 = v2;
            let v4 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Lot>(&arg0.id, v1);
            let v5 = DurationKey{dummy_field: false};
            if (0x2::dynamic_field::exists<DurationKey>(&v4.id, v5)) {
                let v6 = DurationKey{dummy_field: false};
                let v7 = *0x2::dynamic_field::borrow<DurationKey, u64>(&v4.id, v6);
                if (v7 < v2) {
                    v3 = v7;
                };
            };
            let v8 = arg1 + v3;
            reset_auction(arg0);
            arg0.maybe_started_at = 0x1::option::some<u64>(arg1);
            arg0.maybe_ends_at = 0x1::option::some<u64>(v8);
            let v9 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Lot>(&arg0.id, v1);
            let v10 = LiveLotEvent{
                nft_type        : arg0.nft_type,
                lot_id          : 0x2::object::id<Lot>(v9),
                nft_id          : v1,
                coin_type       : v9.coin_type,
                seller          : v9.seller,
                seller_kiosk_id : v9.seller_kiosk_id,
                starting_price  : v9.starting_price,
                started_at      : arg1,
                ends_at         : v8,
            };
            0x2::event::emit<LiveLotEvent>(v10);
        };
    }

    fun type_key<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x1::type_name::as_string(&v0)
    }

    entry fun update_config<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<0x1::ascii::String>, arg7: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg7);
        assert!(arg2 > 0, 14);
        assert!(arg4 > 0, 14);
        assert!(arg5 <= 10000, 14);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, Config>(&mut arg0.configs, v0);
        v1.starting_price = arg1;
        v1.duration = arg2;
        v1.extension = arg3;
        v1.increment = arg4;
        v1.increment_bps = arg5;
        v1.allowed_coins = arg6;
        let v2 = ConfigureAuctionEvent{
            nft_type       : v0,
            starting_price : arg1,
            duration       : arg2,
            extension      : arg3,
            increment      : arg4,
            increment_bps  : arg5,
            allowed_coins  : arg6,
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

    public fun withdraw<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID) {
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
            settle_price    : _,
            buyout_price    : _,
            should_resubmit : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Lot>(&mut v1.id, arg3);
        let v14 = v5;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v9, 12);
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v14, arg3));
        let v15 = &mut v14;
        remove_duration(v15);
        0x2::object::delete(v14);
        let v16 = WithdrawLotEvent{
            nft_type        : v0,
            lot_id          : 0x2::object::uid_to_inner(&v14),
            nft_id          : arg3,
            coin_type       : v7,
            seller          : v8,
            seller_kiosk_id : v9,
        };
        0x2::event::emit<WithdrawLotEvent>(v16);
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

