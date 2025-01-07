module 0xb006bd91a0b4961dc8a2ca276715c3b8a12a484890e79b79225765f628a97e73::atlansui {
    struct ATLANSUI has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Collection<phantom T0, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        total_value: u64,
        total_scoin_value: u64,
        offers: 0x2::vec_map::VecMap<address, Offers>,
        interest: u64,
        name: 0x1::ascii::String,
        url: 0x1::ascii::String,
        loan_duration: u64,
        best_offer_value: u64,
        best_offer_user: 0x1::option::Option<address>,
        best_idx: u64,
    }

    struct Offers has store, key {
        id: 0x2::object::UID,
        counter: u64,
        offers: 0x2::object_table::ObjectTable<u64, Offer>,
    }

    struct Offer has store, key {
        id: 0x2::object::UID,
        collection: 0x1::ascii::String,
        borrower: 0x1::option::Option<address>,
        item_id: 0x1::option::Option<0x2::object::ID>,
        creator: address,
        start_time: u64,
        value: u64,
        is_started: bool,
        is_repayment: bool,
        is_claimed: bool,
    }

    struct ScallopKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Scallop<phantom T0> has store, key {
        id: 0x2::object::UID,
        lender: address,
        balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_recipient: address,
        total_pools: u64,
    }

    struct Rentables has drop {
        dummy_field: bool,
    }

    struct Rented has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Promise {
        item: Rented,
        duration: u64,
        start_date: u64,
        borrower_kiosk: 0x2::object::ID,
    }

    struct Rentable<T0: store + key> has store {
        object: T0,
        duration: u64,
        start_date: u64,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct CreateOfferEvent<phantom T0: store + key> has copy, drop {
        id: 0x2::object::ID,
        key: u64,
        collection: 0x1::ascii::String,
        creator: address,
        value: u64,
        s_coin_value: u64,
        time: u64,
    }

    struct CreateCollectionEvent has copy, drop {
        id: 0x2::object::ID,
        interest: u64,
        name: 0x1::ascii::String,
        url: 0x1::ascii::String,
        time: u64,
    }

    struct CancelOfferEvent has copy, drop {
        id: 0x2::object::ID,
        collection: 0x1::ascii::String,
        creator: address,
        time: u64,
    }

    struct AcceptOfferEvent<phantom T0: store + key> has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        creator: address,
        borrower: address,
        borrower_kiosk: 0x2::object::ID,
        borrower_kiosk_cap: 0x2::object::ID,
        value: u64,
        total_value: u64,
        s_coin_return: u64,
        time: u64,
    }

    struct RepaymentEvent has copy, drop {
        offer_id: 0x2::object::ID,
        creator: address,
        borrower: address,
        borrower_kiosk: 0x2::object::ID,
        value: u64,
        time: u64,
    }

    struct ClaimOfferEvent has copy, drop {
        offer_id: 0x2::object::ID,
        creator: address,
        interest_value: u64,
        time: u64,
    }

    public fun borrow<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : &T0 {
        assert!(0x2::kiosk::has_access(arg0, arg1), 4);
        let v0 = Rentables{dummy_field: false};
        let v1 = Rented{id: arg2};
        &0x2::bag::borrow<Rented, Rentable<T0>>(0x2::kiosk_extension::storage<Rentables>(v0, arg0), v1).object
    }

    public entry fun remove(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk_extension::remove<Rentables>(arg0, arg1);
    }

    public fun accept_offer_with_kiosk_with_scallop<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: address, arg5: u64, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: 0x2::object::ID, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg6, arg7), 4);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        if (0x1::option::contains<address>(&v2.best_offer_user, &arg4) && v2.best_idx == arg5) {
            v2.best_offer_value = 0;
            let v3 = 0x2::vec_map::keys<address, Offers>(&v2.offers);
            while (0x1::vector::length<address>(&v3) > 0) {
                let v4 = 0x1::vector::pop_back<address>(&mut v3);
                let v5 = 0x2::vec_map::get<address, Offers>(&v2.offers, &v4);
                let v6 = 0;
                while (v6 < v5.counter) {
                    if (arg4 != v4 || arg5 != v6) {
                        if (0x2::object_table::contains<u64, Offer>(&v5.offers, v6)) {
                            let v7 = 0x2::object_table::borrow<u64, Offer>(&v5.offers, v6);
                            if (!v7.is_started && v7.value > v2.best_offer_value) {
                                v2.best_offer_value = v7.value;
                                0x1::option::swap_or_fill<address>(&mut v2.best_offer_user, v7.creator);
                                v2.best_idx = v6;
                            };
                        };
                    };
                    v6 = v6 + 1;
                };
            };
        };
        let v8 = 0x2::vec_map::get_mut<address, Offers>(&mut v2.offers, &arg4);
        assert!(v8.counter > arg5, 104);
        let v9 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v8.offers, arg5);
        assert!(!v9.is_started, 103);
        0x2::dynamic_object_field::add<bool, 0x2::kiosk::PurchaseCap<T1>>(&mut v9.id, true, 0x2::kiosk::list_with_purchase_cap<T1>(arg6, arg7, arg8, 0, arg10));
        v9.start_time = v1;
        v9.is_started = true;
        0x1::option::fill<address>(&mut v9.borrower, v0);
        0x1::option::fill<0x2::object::ID>(&mut v9.item_id, arg8);
        let v10 = ScallopKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<ScallopKey<T0>, Scallop<T0>>(&v9.id, v10), 6);
        let v11 = ScallopKey<T0>{dummy_field: false};
        let Scallop {
            id      : v12,
            lender  : _,
            balance : v14,
        } = 0x2::dynamic_object_field::remove<ScallopKey<T0>, Scallop<T0>>(&mut v9.id, v11);
        let v15 = 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v14, arg10);
        let v16 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, v15, arg9, arg10);
        let v17 = 0x2::coin::value<T0>(&v16);
        let v18 = if (v17 > v9.value) {
            let v19 = 0x2::coin::into_balance<T0>(v16);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v19, v9.value, arg10), v0);
            let v20 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(v19, arg10), arg9, arg10);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v20, v9.creator);
            0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v20)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, v0);
            0
        };
        0x2::object::delete(v12);
        v2.total_value = v2.total_value - v9.value;
        v2.total_scoin_value = v2.total_scoin_value - 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v15);
        let v21 = AcceptOfferEvent<Collection<T0, T1>>{
            offer_id           : 0x2::object::id<Offer>(v9),
            nft_id             : arg8,
            creator            : v9.creator,
            borrower           : v0,
            borrower_kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(arg6),
            borrower_kiosk_cap : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(arg7),
            value              : v9.value,
            total_value        : v17,
            s_coin_return      : v18,
            time               : v1,
        };
        0x2::event::emit<AcceptOfferEvent<Collection<T0, T1>>>(v21);
    }

    public fun accept_offer_with_nft_with_scallop<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: address, arg5: u64, arg6: T1, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        if (0x1::option::contains<address>(&v2.best_offer_user, &arg4) && v2.best_idx == arg5) {
            v2.best_offer_value = 0;
            let v3 = 0x2::vec_map::keys<address, Offers>(&v2.offers);
            while (0x1::vector::length<address>(&v3) > 0) {
                let v4 = 0x1::vector::pop_back<address>(&mut v3);
                let v5 = 0x2::vec_map::get<address, Offers>(&v2.offers, &v4);
                let v6 = 0;
                while (v6 < v5.counter) {
                    if (arg4 != v4 || arg5 != v6) {
                        if (0x2::object_table::contains<u64, Offer>(&v5.offers, v6)) {
                            let v7 = 0x2::object_table::borrow<u64, Offer>(&v5.offers, v6);
                            if (!v7.is_started && v7.value > v2.best_offer_value) {
                                v2.best_offer_value = v7.value;
                                0x1::option::swap_or_fill<address>(&mut v2.best_offer_user, v7.creator);
                                v2.best_idx = v6;
                            };
                        };
                    };
                    v6 = v6 + 1;
                };
            };
        };
        let v8 = 0x2::vec_map::get_mut<address, Offers>(&mut v2.offers, &arg4);
        assert!(v8.counter > arg5, 104);
        let v9 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v8.offers, arg5);
        assert!(!v9.is_started, 103);
        let (v10, v11) = 0x2::kiosk::new(arg8);
        let v12 = v11;
        let v13 = v10;
        let v14 = &mut v13;
        install(v14, &v12, arg8);
        let v15 = 0x2::object::id<T1>(&arg6);
        let v16 = Rentable<T1>{
            object     : arg6,
            duration   : v2.loan_duration,
            start_date : v1,
        };
        let v17 = &mut v13;
        let v18 = Rented{id: v15};
        place_in_bag<T1, Rented>(v17, v18, v16);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v12, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v13);
        v9.start_time = v1;
        v9.is_started = true;
        0x1::option::fill<address>(&mut v9.borrower, v0);
        0x1::option::fill<0x2::object::ID>(&mut v9.item_id, v15);
        let v19 = ScallopKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<ScallopKey<T0>, Scallop<T0>>(&v9.id, v19), 6);
        let v20 = ScallopKey<T0>{dummy_field: false};
        let Scallop {
            id      : v21,
            lender  : _,
            balance : v23,
        } = 0x2::dynamic_object_field::remove<ScallopKey<T0>, Scallop<T0>>(&mut v9.id, v20);
        let v24 = 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v23, arg8);
        let v25 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, v24, arg7, arg8);
        let v26 = 0x2::coin::value<T0>(&v25);
        let v27 = if (v26 > v9.value) {
            let v28 = 0x2::coin::into_balance<T0>(v25);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v28, v9.value, arg8), v0);
            let v29 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(v28, arg8), arg7, arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v29, v9.creator);
            0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v29)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v25, v0);
            0
        };
        0x2::object::delete(v21);
        v2.total_value = v2.total_value - v9.value;
        v2.total_scoin_value = v2.total_scoin_value - 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v24);
        let v30 = AcceptOfferEvent<Collection<T0, T1>>{
            offer_id           : 0x2::object::id<Offer>(v9),
            nft_id             : v15,
            creator            : v9.creator,
            borrower           : v0,
            borrower_kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(&v13),
            borrower_kiosk_cap : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v12),
            value              : v9.value,
            total_value        : v26,
            s_coin_return      : v27,
            time               : v1,
        };
        0x2::event::emit<AcceptOfferEvent<Collection<T0, T1>>>(v30);
    }

    public fun accept_offer_with_originbyte_kiosk_with_scallop<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: address, arg5: u64, arg6: &mut 0x2::kiosk::Kiosk, arg7: 0x2::object::ID, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        if (0x1::option::contains<address>(&v2.best_offer_user, &arg4) && v2.best_idx == arg5) {
            v2.best_offer_value = 0;
            let v3 = 0x2::vec_map::keys<address, Offers>(&v2.offers);
            while (0x1::vector::length<address>(&v3) > 0) {
                let v4 = 0x1::vector::pop_back<address>(&mut v3);
                let v5 = 0x2::vec_map::get<address, Offers>(&v2.offers, &v4);
                let v6 = 0;
                while (v6 < v5.counter) {
                    if (arg4 != v4 || arg5 != v6) {
                        if (0x2::object_table::contains<u64, Offer>(&v5.offers, v6)) {
                            let v7 = 0x2::object_table::borrow<u64, Offer>(&v5.offers, v6);
                            if (!v7.is_started && v7.value > v2.best_offer_value) {
                                v2.best_offer_value = v7.value;
                                0x1::option::swap_or_fill<address>(&mut v2.best_offer_user, v7.creator);
                                v2.best_idx = v6;
                            };
                        };
                    };
                    v6 = v6 + 1;
                };
            };
        };
        let v8 = 0x2::vec_map::get_mut<address, Offers>(&mut v2.offers, &arg4);
        assert!(v8.counter > arg5, 104);
        let v9 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v8.offers, arg5);
        assert!(!v9.is_started, 103);
        let v10 = 0x2::object::id<0x2::kiosk::Kiosk>(arg6);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg6, arg7, &v2.id, arg9);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_nft_type<T1>(arg6, arg7);
        v9.start_time = v1;
        v9.is_started = true;
        0x1::option::fill<address>(&mut v9.borrower, v0);
        0x1::option::fill<0x2::object::ID>(&mut v9.item_id, arg7);
        let v11 = ScallopKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<ScallopKey<T0>, Scallop<T0>>(&v9.id, v11), 6);
        let v12 = ScallopKey<T0>{dummy_field: false};
        let Scallop {
            id      : v13,
            lender  : _,
            balance : v15,
        } = 0x2::dynamic_object_field::remove<ScallopKey<T0>, Scallop<T0>>(&mut v9.id, v12);
        let v16 = 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v15, arg9);
        let v17 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, v16, arg8, arg9);
        let v18 = 0x2::coin::value<T0>(&v17);
        let v19 = if (v18 > v9.value) {
            let v20 = 0x2::coin::into_balance<T0>(v17);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v20, v9.value, arg9), v0);
            let v21 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(v20, arg9), arg8, arg9);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v21, v9.creator);
            0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v21)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v17, v0);
            0
        };
        0x2::object::delete(v13);
        v2.total_value = v2.total_value - v9.value;
        v2.total_scoin_value = v2.total_scoin_value - 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v16);
        let v22 = AcceptOfferEvent<Collection<T0, T1>>{
            offer_id           : 0x2::object::id<Offer>(v9),
            nft_id             : arg7,
            creator            : v9.creator,
            borrower           : v0,
            borrower_kiosk     : v10,
            borrower_kiosk_cap : v10,
            value              : v9.value,
            total_value        : v18,
            s_coin_return      : v19,
            time               : v1,
        };
        0x2::event::emit<AcceptOfferEvent<Collection<T0, T1>>>(v22);
    }

    public fun borrow_val<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (T0, Promise) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 4);
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg0);
        let v1 = Rented{id: arg2};
        let v2 = take_from_bag<T0, Rented>(arg0, v1);
        assert!(v2.start_date + v2.duration > 0x2::clock::timestamp_ms(arg3), 108);
        let v3 = Rented{id: arg2};
        let v4 = Promise{
            item           : v3,
            duration       : v2.duration,
            start_date     : v2.start_date,
            borrower_kiosk : v0,
        };
        let Rentable {
            object     : v5,
            duration   : _,
            start_date : _,
        } = v2;
        (v5, v4)
    }

    public fun cancel_offer_with_scallop<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &v0);
        assert!(v2.counter > arg4, 104);
        let v3 = 0x2::object_table::remove<u64, Offer>(&mut v2.offers, arg4);
        assert!(v3.creator == v0, 401);
        assert!(!v3.is_started, 103);
        let Offer {
            id           : v4,
            collection   : v5,
            borrower     : _,
            item_id      : _,
            creator      : v8,
            start_time   : _,
            value        : v10,
            is_started   : _,
            is_repayment : _,
            is_claimed   : _,
        } = v3;
        let v14 = v4;
        let v15 = ScallopKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<ScallopKey<T0>, Scallop<T0>>(&v14, v15), 6);
        let v16 = ScallopKey<T0>{dummy_field: false};
        let Scallop {
            id      : v17,
            lender  : _,
            balance : v19,
        } = 0x2::dynamic_object_field::remove<ScallopKey<T0>, Scallop<T0>>(&mut v14, v16);
        let v20 = 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v19, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, v20, arg5, arg6), v0);
        0x2::object::delete(v14);
        0x2::object::delete(v17);
        v1.total_value = v1.total_value - v10;
        v1.total_scoin_value = v1.total_scoin_value - 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v20);
        if (0x1::option::contains<address>(&v1.best_offer_user, &v0) && v1.best_idx == arg4) {
            v1.best_offer_value = 0;
            let v21 = 0x2::vec_map::keys<address, Offers>(&v1.offers);
            while (0x1::vector::length<address>(&v21) > 0) {
                let v22 = 0x1::vector::pop_back<address>(&mut v21);
                let v23 = 0x2::vec_map::get<address, Offers>(&v1.offers, &v22);
                let v24 = 0;
                while (v24 < v23.counter) {
                    if (0x2::object_table::contains<u64, Offer>(&v23.offers, v24)) {
                        let v25 = 0x2::object_table::borrow<u64, Offer>(&v23.offers, v24);
                        if (!v25.is_started && v25.value > v1.best_offer_value) {
                            v1.best_offer_value = v25.value;
                            0x1::option::swap_or_fill<address>(&mut v1.best_offer_user, v25.creator);
                            v1.best_idx = v24;
                        };
                    };
                    v24 = v24 + 1;
                };
            };
        };
        let v26 = CancelOfferEvent{
            id         : 0x2::object::id<Offer>(&v3),
            collection : v5,
            creator    : v8,
            time       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CancelOfferEvent>(v26);
    }

    public entry fun change_fee_bps(arg0: &mut Platform, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 10000, 3);
        arg0.fee_bps = arg2;
    }

    public entry fun change_fee_recipient(arg0: &mut Platform, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.fee_recipient = arg2;
    }

    public entry fun change_interest<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: &AdminCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1).interest = arg3;
    }

    public entry fun change_loan_duration<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: &AdminCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1).loan_duration = arg3;
    }

    public fun claim_offer<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &v0);
        assert!(v2.counter > arg2, 104);
        let v3 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v2.offers, arg2);
        assert!(v3.creator == v0, 401);
        assert!(v3.collection == v1.name, 107);
        assert!(v3.is_started, 105);
        assert!(!v3.is_repayment, 600);
        assert!(!v3.is_claimed, 601);
        assert!(v3.start_time + v1.loan_duration < 0x2::clock::timestamp_ms(arg4), 106);
        let v4 = Rented{id: 0x1::option::extract<0x2::object::ID>(&mut v3.item_id)};
        let Rentable {
            object     : v5,
            duration   : _,
            start_date : _,
        } = take_from_bag<T1, Rented>(arg3, v4);
        0x2::transfer::public_transfer<T1>(v5, v0);
        v3.is_claimed = true;
        let v8 = ClaimOfferEvent{
            offer_id       : 0x2::object::id<Offer>(v3),
            creator        : v3.creator,
            interest_value : mul_div(mul_div(v1.loan_duration, mul_div(v1.interest, 10000000, 365) / 86400, 1000), v3.value, 1000000000),
            time           : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClaimOfferEvent>(v8);
    }

    public fun claim_offer_originbyte_kiosk<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T1> {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &v0);
        assert!(v2.counter > arg2, 104);
        let v3 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v2.offers, arg2);
        assert!(v3.creator == v0, 401);
        assert!(v3.collection == v1.name, 107);
        assert!(v3.is_started, 105);
        assert!(!v3.is_repayment, 600);
        assert!(!v3.is_claimed, 601);
        assert!(v3.start_time + v1.loan_duration < 0x2::clock::timestamp_ms(arg4), 106);
        let v4 = 0x1::option::extract<0x2::object::ID>(&mut v3.item_id);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_nft_type<T1>(arg3, v4);
        let (v5, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(v0, arg5);
        let v7 = v5;
        let v8 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T1>(arg3, &mut v7, v4, &v1.id, 0, arg5);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_nothing_paid<T1>(&mut v8);
        let v9 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T1, Witness>(&mut v8, &v9);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v7);
        v3.is_claimed = true;
        let v10 = ClaimOfferEvent{
            offer_id       : 0x2::object::id<Offer>(v3),
            creator        : v3.creator,
            interest_value : mul_div(mul_div(v1.loan_duration, mul_div(v1.interest, 10000000, 365) / 86400, 1000), v3.value, 1000000000),
            time           : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClaimOfferEvent>(v10);
        v8
    }

    public fun claim_offer_with_kiosk<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T1> {
        assert!(0x2::kiosk::has_access(arg4, arg5), 4);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &v0);
        assert!(v2.counter > arg2, 104);
        let v3 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v2.offers, arg2);
        assert!(v3.creator == v0, 401);
        assert!(v3.collection == v1.name, 107);
        assert!(v3.is_started, 105);
        assert!(!v3.is_repayment, 600);
        assert!(!v3.is_claimed, 601);
        assert!(v3.start_time + v1.loan_duration < 0x2::clock::timestamp_ms(arg7), 106);
        assert!(0x2::dynamic_object_field::exists_<bool>(&v3.id, true), 501);
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<T1>(arg3, 0x2::dynamic_object_field::remove<bool, 0x2::kiosk::PurchaseCap<T1>>(&mut v3.id, true), 0x2::coin::zero<0x2::sui::SUI>(arg8));
        0x2::kiosk::lock<T1>(arg4, arg5, arg6, v4);
        v3.is_claimed = true;
        let v6 = ClaimOfferEvent{
            offer_id       : 0x2::object::id<Offer>(v3),
            creator        : v3.creator,
            interest_value : mul_div(mul_div(v1.loan_duration, mul_div(v1.interest, 10000000, 365) / 86400, 1000), v3.value, 1000000000),
            time           : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ClaimOfferEvent>(v6);
        v5
    }

    public fun create_collection<T0, T1: store + key>(arg0: &mut Platform, arg1: &AdminCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection<T0, T1>{
            id                : 0x2::object::new(arg7),
            total_value       : 0,
            total_scoin_value : 0,
            offers            : 0x2::vec_map::empty<address, Offers>(),
            interest          : arg5,
            name              : arg2,
            url               : arg3,
            loan_duration     : arg4,
            best_offer_value  : 0,
            best_offer_user   : 0x1::option::none<address>(),
            best_idx          : 0,
        };
        let v1 = 0x2::object::id<Collection<T0, T1>>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, v1, v0);
        arg0.total_pools = arg0.total_pools + 1;
        let v2 = CreateCollectionEvent{
            id       : v1,
            interest : arg5,
            name     : arg2,
            url      : arg3,
            time     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CreateCollectionEvent>(v2);
    }

    public fun create_offer_with_scallop<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        assert!(arg5 == 0x2::coin::value<T0>(&arg4), 201);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        if (!0x2::vec_map::contains<address, Offers>(&v1.offers, &v0)) {
            let v2 = Offers{
                id      : 0x2::object::new(arg7),
                counter : 0,
                offers  : 0x2::object_table::new<u64, Offer>(arg7),
            };
            0x2::vec_map::insert<address, Offers>(&mut v1.offers, v0, v2);
        };
        let v3 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &v0);
        let v4 = Offer{
            id           : 0x2::object::new(arg7),
            collection   : v1.name,
            borrower     : 0x1::option::none<address>(),
            item_id      : 0x1::option::none<0x2::object::ID>(),
            creator      : v0,
            start_time   : 0,
            value        : arg5,
            is_started   : false,
            is_repayment : false,
            is_claimed   : false,
        };
        let v5 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, arg4, arg6, arg7);
        let v6 = 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v5);
        let v7 = ScallopKey<T0>{dummy_field: false};
        let v8 = Scallop<T0>{
            id      : 0x2::object::new(arg7),
            lender  : v0,
            balance : 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v5),
        };
        0x2::dynamic_object_field::add<ScallopKey<T0>, Scallop<T0>>(&mut v4.id, v7, v8);
        0x2::object_table::add<u64, Offer>(&mut v3.offers, v3.counter, v4);
        if (arg5 > v1.best_offer_value) {
            v1.best_offer_value = arg5;
            0x1::option::swap_or_fill<address>(&mut v1.best_offer_user, v0);
            v1.best_idx = v3.counter;
        };
        v3.counter = v3.counter + 1;
        v1.total_value = v1.total_value + arg5;
        v1.total_scoin_value = v1.total_scoin_value + v6;
        let v9 = CreateOfferEvent<Collection<T0, T1>>{
            id           : 0x2::object::id<Offer>(&v4),
            key          : v3.counter - 1,
            collection   : v1.name,
            creator      : v0,
            value        : arg5,
            s_coin_value : v6,
            time         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CreateOfferEvent<Collection<T0, T1>>>(v9);
    }

    public entry fun emergency_remove_auth_transfer<T0, T1: store + key>(arg0: &AdminCap, arg1: &mut Platform, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg1.id, arg2), 2);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_nft_type<T1>(arg3, arg4);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::remove_auth_transfer(arg3, arg4, &0x2::dynamic_object_field::borrow<0x2::object::ID, Collection<T0, T1>>(&arg1.id, arg2).id);
    }

    public entry fun emergency_remove_purchase_cap<T0, T1: store + key>(arg0: &AdminCap, arg1: &mut Platform, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg1.id, arg2), 2);
        let v0 = 0x2::vec_map::get_mut<address, Offers>(&mut 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg1.id, arg2).offers, &arg3);
        assert!(v0.counter > arg4, 104);
        let v1 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v0.offers, arg4);
        assert!(0x2::dynamic_object_field::exists_<bool>(&v1.id, true), 501);
        0x2::kiosk::return_purchase_cap<T1>(arg5, 0x2::dynamic_object_field::remove<bool, 0x2::kiosk::PurchaseCap<T1>>(&mut v1.id, true));
    }

    fun init(arg0: ATLANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ATLANSUI>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Platform{
            id            : 0x2::object::new(arg1),
            fee_bps       : 1000,
            fee_recipient : @0x7fb4be40d452d6abfe180709e7102f462df812661fcb11f040786adc8e584521,
            total_pools   : 0,
        };
        0x2::transfer::share_object<Platform>(v1);
    }

    public fun install(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Rentables{dummy_field: false};
        0x2::kiosk_extension::add<Rentables>(v0, arg0, arg1, 11, arg2);
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    fun place_in_bag<T0: store + key, T1: copy + drop + store>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T1, arg2: Rentable<T0>) {
        let v0 = Rentables{dummy_field: false};
        0x2::bag::add<T1, Rentable<T0>>(0x2::kiosk_extension::storage_mut<Rentables>(v0, arg0), arg1, arg2);
    }

    public fun repayment_offer<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg4, arg5), 4);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &arg2);
        assert!(v2.counter > arg3, 104);
        let v3 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v2.offers, arg3);
        assert!(0x1::option::contains<address>(&v3.borrower, &v0), 401);
        let v4 = 0x2::clock::timestamp_ms(arg7);
        assert!(v3.is_started, 105);
        assert!(v3.start_time + v1.loan_duration > v4, 108);
        let v5 = mul_div(mul_div(v4 - v3.start_time, mul_div(v1.interest, 10000000, 365) / 86400, 1000), v3.value, 1000000000);
        let v6 = mul_div(v5, arg0.fee_bps, 10000);
        let v7 = v3.value + v5;
        assert!(0x2::coin::value<T0>(&arg6) >= v7, 202);
        0x2::pay::split_and_transfer<T0>(&mut arg6, v6, arg0.fee_recipient, arg8);
        0x2::pay::split_and_transfer<T0>(&mut arg6, v7 - v6, v3.creator, arg8);
        v3.is_repayment = true;
        if (0x2::coin::value<T0>(&arg6) > 0) {
            0x2::pay::keep<T0>(arg6, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
        };
        let v8 = 0x2::object::id<0x2::kiosk::Kiosk>(arg4);
        let v9 = Rented{id: 0x1::option::extract<0x2::object::ID>(&mut v3.item_id)};
        let Rentable {
            object     : v10,
            duration   : _,
            start_date : _,
        } = take_from_bag<T1, Rented>(arg4, v9);
        0x2::transfer::public_transfer<T1>(v10, v0);
        let v13 = RepaymentEvent{
            offer_id       : 0x2::object::id<Offer>(v3),
            creator        : v3.creator,
            borrower       : v0,
            borrower_kiosk : v8,
            value          : v5,
            time           : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<RepaymentEvent>(v13);
    }

    public fun repayment_offer_kiosk<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &arg2);
        assert!(v2.counter > arg3, 104);
        let v3 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v2.offers, arg3);
        assert!(0x1::option::contains<address>(&v3.borrower, &v0), 401);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        assert!(v3.is_started, 105);
        assert!(v3.start_time + v1.loan_duration > v4, 108);
        let v5 = mul_div(mul_div(v4 - v3.start_time, mul_div(v1.interest, 10000000, 365) / 86400, 1000), v3.value, 1000000000);
        let v6 = mul_div(v5, arg0.fee_bps, 10000);
        let v7 = v3.value + v5;
        assert!(0x2::coin::value<T0>(&arg5) >= v7, 202);
        0x2::pay::split_and_transfer<T0>(&mut arg5, v6, arg0.fee_recipient, arg7);
        0x2::pay::split_and_transfer<T0>(&mut arg5, v7 - v6, v3.creator, arg7);
        v3.is_repayment = true;
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x2::pay::keep<T0>(arg5, arg7);
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        assert!(0x2::dynamic_object_field::exists_<bool>(&v3.id, true), 501);
        0x2::kiosk::return_purchase_cap<T1>(arg4, 0x2::dynamic_object_field::remove<bool, 0x2::kiosk::PurchaseCap<T1>>(&mut v3.id, true));
        let v8 = RepaymentEvent{
            offer_id       : 0x2::object::id<Offer>(v3),
            creator        : v3.creator,
            borrower       : v0,
            borrower_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            value          : v5,
            time           : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<RepaymentEvent>(v8);
    }

    public fun repayment_offer_originbyte_kiosk<T0, T1: store + key>(arg0: &mut Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Collection<T0, T1>>(&mut arg0.id, arg1);
        let v2 = 0x2::vec_map::get_mut<address, Offers>(&mut v1.offers, &arg2);
        assert!(v2.counter > arg3, 104);
        let v3 = 0x2::object_table::borrow_mut<u64, Offer>(&mut v2.offers, arg3);
        assert!(0x1::option::contains<address>(&v3.borrower, &v0), 401);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        assert!(v3.is_started, 105);
        assert!(v3.start_time + v1.loan_duration > v4, 108);
        let v5 = mul_div(mul_div(v4 - v3.start_time, mul_div(v1.interest, 10000000, 365) / 86400, 1000), v3.value, 1000000000);
        let v6 = mul_div(v5, arg0.fee_bps, 10000);
        let v7 = v3.value + v5;
        assert!(0x2::coin::value<T0>(&arg5) >= v7, 202);
        0x2::pay::split_and_transfer<T0>(&mut arg5, v6, arg0.fee_recipient, arg7);
        0x2::pay::split_and_transfer<T0>(&mut arg5, v7 - v6, v3.creator, arg7);
        v3.is_repayment = true;
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x2::pay::keep<T0>(arg5, arg7);
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        let v8 = 0x1::option::extract<0x2::object::ID>(&mut v3.item_id);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_nft_type<T1>(arg4, v8);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::remove_auth_transfer(arg4, v8, &v1.id);
        let v9 = RepaymentEvent{
            offer_id       : 0x2::object::id<Offer>(v3),
            creator        : v3.creator,
            borrower       : v0,
            borrower_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            value          : v5,
            time           : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<RepaymentEvent>(v9);
    }

    public fun return_val<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T0, arg2: Promise, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk_extension::is_installed<Rentables>(arg0), 0);
        let Promise {
            item           : v0,
            duration       : v1,
            start_date     : v2,
            borrower_kiosk : v3,
        } = arg2;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == v3, 5);
        let v4 = Rentable<T0>{
            object     : arg1,
            duration   : v1,
            start_date : v2,
        };
        place_in_bag<T0, Rented>(arg0, v0, v4);
    }

    fun take_from_bag<T0: store + key, T1: copy + drop + store>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T1) : Rentable<T0> {
        let v0 = Rentables{dummy_field: false};
        let v1 = 0x2::kiosk_extension::storage_mut<Rentables>(v0, arg0);
        assert!(0x2::bag::contains<T1>(v1, arg1), 501);
        0x2::bag::remove<T1, Rentable<T0>>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}

