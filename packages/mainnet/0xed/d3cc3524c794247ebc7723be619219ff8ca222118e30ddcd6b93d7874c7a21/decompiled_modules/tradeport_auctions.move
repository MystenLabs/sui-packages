module 0xedd3cc3524c794247ebc7723be619219ff8ca222118e30ddcd6b93d7874c7a21::tradeport_auctions {
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
        extension: u64,
        increment: u64,
        increment_bps: u64,
        concurrency: u64,
        stagger: u64,
        allowed_coins: vector<0x1::ascii::String>,
        paused: bool,
        paused_until: u64,
    }

    struct Auction has store, key {
        id: 0x2::object::UID,
        nft_type: 0x1::ascii::String,
        live: vector<0x2::object::ID>,
        waiting: vector<0x2::object::ID>,
        last_started_at: u64,
    }

    struct Lot has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        duration: u64,
        starting_price: u64,
        settle_price: u64,
        buyout_price: u64,
        should_resubmit: bool,
        started_at: u64,
        ends_at: u64,
        top_bidder: address,
        top_price: u64,
        top_royalty: u64,
        top_fee: u64,
        extended: bool,
    }

    struct ConfigureAuctionEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        starting_price: u64,
        duration: u64,
        extension: u64,
        increment: u64,
        increment_bps: u64,
        concurrency: u64,
        stagger: u64,
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
        duration: u64,
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
        top_bidder: address,
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

    entry fun create_auction<T0: store + key>(arg0: &mut Store, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<0x1::ascii::String>, arg10: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg10);
        assert!(arg3 > 0, 14);
        assert!(arg5 > 0, 14);
        assert!(arg6 <= 10000, 14);
        assert!(arg7 > 0, 14);
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
            concurrency    : arg7,
            stagger        : arg8,
            allowed_coins  : arg9,
            paused         : false,
            paused_until   : 0,
        };
        0x2::table::add<0x1::ascii::String, Config>(&mut arg0.configs, v0, v1);
        let v2 = Auction{
            id              : 0x2::object::new(arg10),
            nft_type        : v0,
            live            : 0x1::vector::empty<0x2::object::ID>(),
            waiting         : 0x1::vector::empty<0x2::object::ID>(),
            last_started_at : 0,
        };
        0x2::object_table::add<0x1::ascii::String, Auction>(&mut arg0.auctions, v0, v2);
        let v3 = ConfigureAuctionEvent{
            nft_type       : v0,
            starting_price : arg2,
            duration       : arg3,
            extension      : arg4,
            increment      : arg5,
            increment_bps  : arg6,
            concurrency    : arg7,
            stagger        : arg8,
            allowed_coins  : arg9,
        };
        0x2::event::emit<ConfigureAuctionEvent>(v3);
    }

    fun fill_live_slots(arg0: &mut Auction, arg1: u64, arg2: &Config) {
        loop {
            let v0 = if (0x1::vector::length<0x2::object::ID>(&arg0.live) < arg2.concurrency) {
                if (!0x1::vector::is_empty<0x2::object::ID>(&arg0.waiting)) {
                    !arg2.paused
                } else {
                    false
                }
            } else {
                false
            };
            if (v0) {
                let v1 = if (arg0.last_started_at + arg2.stagger > arg1) {
                    arg0.last_started_at + arg2.stagger
                } else {
                    arg1
                };
                arg0.last_started_at = v1;
                let v2 = 0x1::vector::remove<0x2::object::ID>(&mut arg0.waiting, 0);
                0x1::vector::push_back<0x2::object::ID>(&mut arg0.live, v2);
                let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lot>(&mut arg0.id, v2);
                let v4 = if (v3.duration == 0 || v3.duration > arg2.duration) {
                    arg2.duration
                } else {
                    v3.duration
                };
                let v5 = v1 + v4;
                v3.started_at = v1;
                v3.ends_at = v5;
                let v6 = LiveLotEvent{
                    nft_type        : arg0.nft_type,
                    lot_id          : 0x2::object::id<Lot>(v3),
                    nft_id          : v2,
                    coin_type       : v3.coin_type,
                    seller          : v3.seller,
                    seller_kiosk_id : v3.seller_kiosk_id,
                    starting_price  : v3.starting_price,
                    started_at      : v1,
                    ends_at         : v5,
                };
                0x2::event::emit<LiveLotEvent>(v6);
            } else {
                break
            };
        };
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
        assert!(0x1::vector::contains<0x2::object::ID>(&v6.live, &arg3), 15);
        let v7 = if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, arg4)
        } else {
            0
        };
        let v8 = (((arg4 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        assert!(0x2::coin::value<T1>(&arg5) == arg4 + v7 + v8, 16);
        let v9 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lot>(&mut v6.id, arg3);
        assert!(v9.coin_type == v4, 18);
        assert!(v5 >= v9.started_at, 22);
        assert!(v5 < v9.ends_at, 9);
        let v10 = 0x2::object::id<Lot>(v9);
        let v11 = v9.buyout_price;
        let v12 = v9.top_price;
        let v13 = v11 > 0 && arg4 >= v11;
        if (v13) {
            let v14 = if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg2)) {
                let v15 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2) && 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, 0) > 0;
                !v15
            } else {
                false
            };
            assert!(v14, 13);
        };
        if (v12 == 0) {
            assert!(arg4 >= v9.starting_price, 7);
            0x2::dynamic_field::add<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v9.id, v10, 0x2::coin::into_balance<T1>(arg5));
        } else {
            if (!v13) {
                let v16 = if (v9.extended && v2 > 0) {
                    if (v12 >= 10000) {
                        (((v12 as u128) * (v2 as u128) / (10000 as u128)) as u64)
                    } else {
                        10000
                    }
                } else {
                    v1.increment
                };
                assert!(arg4 >= v12 + v16, 7);
            };
            let v17 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v9.id, v10);
            0x2::balance::send_funds<T1>(0x2::balance::withdraw_all<T1>(v17), v9.top_bidder);
            0x2::balance::join<T1>(v17, 0x2::coin::into_balance<T1>(arg5));
        };
        let v18 = 0x2::tx_context::sender(arg7);
        v9.top_price = arg4;
        v9.top_royalty = v7;
        v9.top_fee = v8;
        v9.top_bidder = v18;
        let v19 = v9.ends_at;
        let v20 = v19;
        if (v13) {
            v20 = v5;
        } else if (v3 > 0 && v19 - v5 <= v3) {
            let v21 = v5 + v3;
            v20 = v21;
            v9.ends_at = v21;
            v9.extended = true;
        };
        let v22 = PlaceTopBidEvent{
            nft_type   : v0,
            lot_id     : v10,
            nft_id     : arg3,
            coin_type  : v4,
            top_bidder : v18,
            price      : arg4,
            royalty    : v7,
            fee        : v8,
            ends_at    : v20,
            extended   : v9.extended,
        };
        0x2::event::emit<PlaceTopBidEvent>(v22);
        if (v13) {
            let (_, v24) = 0x1::vector::index_of<0x2::object::ID>(&v6.live, &arg3);
            0x1::vector::remove<0x2::object::ID>(&mut v6.live, v24);
            let v25 = &mut arg0.royalties;
            sell_lot<T0, T1>(arg1, arg2, v25, 0x2::dynamic_object_field::remove<0x2::object::ID, Lot>(&mut v6.id, arg3), v0, v18, arg4, v7, v8, arg0.beneficiary, arg7);
            let v26 = *0x2::table::borrow<0x1::ascii::String, Config>(&arg0.configs, v0);
            fill_live_slots(v6, v5, &v26);
        };
    }

    fun reset_lot(arg0: &mut Lot) {
        arg0.started_at = 0;
        arg0.ends_at = 0;
        arg0.top_bidder = @0x0;
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
            fill_live_slots(v2, 0x2::clock::timestamp_ms(arg1), v1);
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
            duration        : _,
            starting_price  : _,
            settle_price    : _,
            buyout_price    : _,
            should_resubmit : _,
            started_at      : _,
            ends_at         : _,
            top_bidder      : _,
            top_price       : _,
            top_royalty     : _,
            top_fee         : _,
            extended        : _,
        } = arg3;
        let v17 = v0;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == v4, 12);
        assert!(v2 == type_key<T1>(), 18);
        let v18 = 0x2::object::uid_to_inner(&v17);
        let (v19, v20) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v17, v1), 0x2::coin::zero<0x2::sui::SUI>(arg10));
        let v21 = v20;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg1)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg1, &mut v21, 0x2::coin::zero<0x2::sui::SUI>(arg10));
        };
        let (v22, v23) = 0x2::kiosk::new(arg10);
        let v24 = v23;
        let v25 = v22;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg1)) {
            0x2::kiosk::lock<T0>(&mut v25, &v24, arg1, v19);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v21, &v25);
        } else {
            0x2::kiosk::place<T0>(&mut v25, &v24, v19);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v25, v24, arg5, arg10);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg1)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(&v25, &mut v21);
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v21);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v25);
        let v29 = 0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v17, v18);
        0x2::balance::send_funds<T1>(0x2::balance::split<T1>(&mut v29, arg6), v3);
        if (arg7 > 0) {
            let v30 = RoyaltyKey<T0, T1>{policy_id: 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg1)};
            if (!0x2::bag::contains<RoyaltyKey<T0, T1>>(arg2, v30)) {
                0x2::bag::add<RoyaltyKey<T0, T1>, 0x2::balance::Balance<T1>>(arg2, v30, 0x2::balance::zero<T1>());
            };
            0x2::balance::join<T1>(0x2::bag::borrow_mut<RoyaltyKey<T0, T1>, 0x2::balance::Balance<T1>>(arg2, v30), 0x2::balance::split<T1>(&mut v29, arg7));
        };
        if (arg8 > 0) {
            0x2::balance::send_funds<T1>(v29, arg9);
        } else {
            0x2::balance::destroy_zero<T1>(v29);
        };
        let v31 = SoldLotEvent{
            nft_type        : arg4,
            lot_id          : v18,
            nft_id          : v1,
            coin_type       : v2,
            seller          : v3,
            seller_kiosk_id : v4,
            top_bidder      : arg5,
            price           : arg6,
            royalty         : arg7,
            fee             : arg8,
        };
        0x2::event::emit<SoldLotEvent>(v31);
        0x2::object::delete(v17);
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

    entry fun set_ends_at<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg4);
        let v0 = type_key<T0>();
        assert!(0x2::object_table::contains<0x1::ascii::String, Auction>(&arg0.auctions, v0), 4);
        let v1 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        assert!(0x1::vector::contains<0x2::object::ID>(&v1.live, &arg1), 8);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg3), 14);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lot>(&mut v1.id, arg1);
        v2.ends_at = arg2;
        let v3 = UpdateLotEvent{
            nft_type  : v0,
            lot_id    : 0x2::object::id<Lot>(v2),
            nft_id    : arg1,
            coin_type : v2.coin_type,
            ends_at   : arg2,
        };
        0x2::event::emit<UpdateLotEvent>(v3);
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

    entry fun settle<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg5);
        let v0 = type_key<T0>();
        assert!(0x2::object_table::contains<0x1::ascii::String, Auction>(&arg0.auctions, v0), 4);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        let (v3, v4) = 0x1::vector::index_of<0x2::object::ID>(&v2.live, &arg3);
        assert!(v3, 8);
        0x1::vector::remove<0x2::object::ID>(&mut v2.live, v4);
        let v5 = 0x2::dynamic_object_field::remove<0x2::object::ID, Lot>(&mut v2.id, arg3);
        if (arg0.operator == 0x2::tx_context::sender(arg5)) {
            assert!(v1 >= v5.ends_at, 10);
        };
        let v6 = v5.top_price;
        let v7 = v5.top_bidder;
        let v8 = if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg2)) {
            let v9 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2) && 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, 0) > 0;
            !v9
        } else {
            false
        };
        let v10 = if (v6 > 0) {
            if (v6 >= v5.settle_price) {
                v8
            } else {
                false
            }
        } else {
            false
        };
        if (v10) {
            let v11 = &mut arg0.royalties;
            sell_lot<T0, T1>(arg1, arg2, v11, v5, v0, v7, v6, v5.top_royalty, v5.top_fee, arg0.beneficiary, arg5);
        } else if (v5.should_resubmit) {
            let v12 = 0x2::object::id<Lot>(&v5);
            let v13 = v5.coin_type;
            assert!(v13 == type_key<T1>(), 18);
            if (v6 > 0) {
                0x2::balance::send_funds<T1>(0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v5.id, v12), v7);
            };
            let v14 = &mut v5;
            reset_lot(v14);
            0x2::dynamic_object_field::add<0x2::object::ID, Lot>(&mut v2.id, arg3, v5);
            0x1::vector::push_back<0x2::object::ID>(&mut v2.waiting, arg3);
            let v15 = ResubmitLotEvent{
                nft_type        : v0,
                lot_id          : v12,
                nft_id          : arg3,
                coin_type       : v13,
                seller          : v5.seller,
                seller_kiosk_id : v5.seller_kiosk_id,
                submitted_at    : v1,
                position        : 0x1::vector::length<0x2::object::ID>(&v2.waiting),
            };
            0x2::event::emit<ResubmitLotEvent>(v15);
        } else {
            let Lot {
                id              : v16,
                nft_id          : _,
                coin_type       : v18,
                seller          : v19,
                seller_kiosk_id : v20,
                duration        : _,
                starting_price  : _,
                settle_price    : _,
                buyout_price    : _,
                should_resubmit : _,
                started_at      : _,
                ends_at         : _,
                top_bidder      : _,
                top_price       : _,
                top_royalty     : _,
                top_fee         : _,
                extended        : _,
            } = v5;
            let v33 = v16;
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v20, 12);
            assert!(v18 == type_key<T1>(), 18);
            let v34 = 0x2::object::uid_to_inner(&v33);
            if (v6 > 0) {
                0x2::balance::send_funds<T1>(0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T1>>(&mut v33, v34), v7);
            };
            0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v33, arg3));
            0x2::object::delete(v33);
            let v35 = ReturnLotEvent{
                nft_type        : v0,
                lot_id          : v34,
                nft_id          : arg3,
                coin_type       : v18,
                seller          : v19,
                seller_kiosk_id : v20,
                top_bidder      : v7,
            };
            0x2::event::emit<ReturnLotEvent>(v35);
        };
        let v36 = *0x2::table::borrow<0x1::ascii::String, Config>(&arg0.configs, v0);
        fill_live_slots(v2, v1, &v36);
    }

    public fun submit<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        let v1 = *0x2::table::borrow<0x1::ascii::String, Config>(&arg0.configs, v0);
        assert!(!v1.paused, 20);
        let v2 = type_key<T1>();
        assert!(0x1::vector::is_empty<0x1::ascii::String>(&v1.allowed_coins) || 0x1::vector::contains<0x1::ascii::String>(&v1.allowed_coins, &v2), 17);
        let v3 = if (v1.starting_price == 0) {
            arg5
        } else {
            v1.starting_price
        };
        assert!(v3 > 0, 6);
        assert!(arg6 == 0 || arg6 >= v3, 21);
        let v4 = if (arg6 == 0) {
            v3
        } else {
            arg6
        };
        assert!(arg7 == 0 || arg7 >= v4, 21);
        let v5 = 0x2::tx_context::sender(arg10);
        let v6 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v7 = 0x2::clock::timestamp_ms(arg9);
        let v8 = Lot{
            id              : 0x2::object::new(arg10),
            nft_id          : arg3,
            coin_type       : v2,
            seller          : v5,
            seller_kiosk_id : v6,
            duration        : arg4,
            starting_price  : v3,
            settle_price    : arg6,
            buyout_price    : arg7,
            should_resubmit : arg8,
            started_at      : 0,
            ends_at         : 0,
            top_bidder      : @0x0,
            top_price       : 0,
            top_royalty     : 0,
            top_fee         : 0,
            extended        : false,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v8.id, arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg10));
        let v9 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Lot>(&mut v9.id, arg3, v8);
        0x1::vector::push_back<0x2::object::ID>(&mut v9.waiting, arg3);
        let v10 = SubmitLotEvent{
            nft_type        : v0,
            lot_id          : 0x2::object::id<Lot>(&v8),
            nft_id          : arg3,
            coin_type       : v2,
            seller          : v5,
            seller_kiosk_id : v6,
            duration        : arg4,
            starting_price  : v3,
            settle_price    : arg6,
            buyout_price    : arg7,
            should_resubmit : arg8,
            submitted_at    : v7,
            position        : 0x1::vector::length<0x2::object::ID>(&v9.waiting),
        };
        0x2::event::emit<SubmitLotEvent>(v10);
        fill_live_slots(v9, v7, &v1);
    }

    fun type_key<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x1::type_name::as_string(&v0)
    }

    entry fun update_config<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<0x1::ascii::String>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg10);
        assert!(arg2 > 0, 14);
        assert!(arg4 > 0, 14);
        assert!(arg5 <= 10000, 14);
        assert!(arg6 > 0, 14);
        let v0 = type_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, Config>(&arg0.configs, v0), 4);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, Config>(&mut arg0.configs, v0);
        v1.starting_price = arg1;
        v1.duration = arg2;
        v1.extension = arg3;
        v1.increment = arg4;
        v1.increment_bps = arg5;
        v1.concurrency = arg6;
        v1.stagger = arg7;
        v1.allowed_coins = arg8;
        let v2 = 0x2::object_table::borrow_mut<0x1::ascii::String, Auction>(&mut arg0.auctions, v0);
        fill_live_slots(v2, 0x2::clock::timestamp_ms(arg9), v1);
        let v3 = ConfigureAuctionEvent{
            nft_type       : v0,
            starting_price : arg1,
            duration       : arg2,
            extension      : arg3,
            increment      : arg4,
            increment_bps  : arg5,
            concurrency    : arg6,
            stagger        : arg7,
            allowed_coins  : arg8,
        };
        0x2::event::emit<ConfigureAuctionEvent>(v3);
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
        assert!(!0x1::vector::contains<0x2::object::ID>(&v1.live, &arg3), 11);
        let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&v1.waiting, &arg3);
        assert!(v2, 5);
        0x1::vector::remove<0x2::object::ID>(&mut v1.waiting, v3);
        let Lot {
            id              : v4,
            nft_id          : _,
            coin_type       : v6,
            seller          : v7,
            seller_kiosk_id : v8,
            duration        : _,
            starting_price  : _,
            settle_price    : _,
            buyout_price    : _,
            should_resubmit : _,
            started_at      : _,
            ends_at         : _,
            top_bidder      : _,
            top_price       : _,
            top_royalty     : _,
            top_fee         : _,
            extended        : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Lot>(&mut v1.id, arg3);
        let v21 = v4;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v8, 12);
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v21, arg3));
        0x2::object::delete(v21);
        let v22 = WithdrawLotEvent{
            nft_type        : v0,
            lot_id          : 0x2::object::uid_to_inner(&v21),
            nft_id          : arg3,
            coin_type       : v6,
            seller          : v7,
            seller_kiosk_id : v8,
        };
        0x2::event::emit<WithdrawLotEvent>(v22);
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

