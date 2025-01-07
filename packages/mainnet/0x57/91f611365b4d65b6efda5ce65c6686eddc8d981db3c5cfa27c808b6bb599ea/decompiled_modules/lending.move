module 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending {
    struct LENDING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        admin_cap_id: 0x2::object::ID,
        version: u64,
    }

    struct CreateOfferEvent has copy, drop {
        id: 0x2::object::ID,
        collection: 0x1::ascii::String,
        creator: address,
        value: u64,
        period: u64,
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

    struct AcceptOfferEvent has copy, drop {
        offer_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        creator: address,
        borrower: address,
        value: u64,
        period: u64,
        time: u64,
    }

    struct RepaymentEvent has copy, drop {
        offer_id: 0x2::object::ID,
        creator: address,
        borrower: address,
        value: u64,
        period: u64,
        time: u64,
    }

    entry fun accept_offer_with_kiosk<T0, T1: store + key>(arg0: &Platform, arg1: &mut 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        accept_offer_with_nft<T0, T1>(arg0, arg1, arg2, arg3, 0x2::kiosk::take<T1>(arg4, arg5, arg6), arg7, arg8);
    }

    entry fun accept_offer_with_nft<T0, T1: store + key>(arg0: &Platform, arg1: &mut 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: T1, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::read_collection<T0>(arg1, arg2);
        let (v2, v3) = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_collection_type_info<T0>(v1);
        let v4 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_value(0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::read_offer<T0>(v1, arg3));
        let v5 = 0x1::type_name::get<T1>();
        assert!(0x1::type_name::get_address(&v5) == v2, 9);
        assert!(0x1::type_name::get_module(&v5) == v3, 9);
        let (v6, v7, v8, v9, v10) = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::create_kiosk<T1>(arg1, arg4, arg6);
        let v11 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::borrow_collection<T0>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::split_collection_balance<T0>(v11, v4, arg6), v0);
        let v12 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::borrow_offer<T0>(v11, arg3);
        assert!(!0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::check_offer_active_status(v12, arg5), 2);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::start_offer(v12, arg5);
        let v13 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_owner(v12);
        assert!(v0 != v13, 4);
        let v14 = AcceptOfferEvent{
            offer_id : 0x2::object::id<0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::Offer>(v12),
            kiosk_id : 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::create_kiosk_data<T1>(v12, v0, v6, v7, v8, v9, v10, arg6),
            creator  : v13,
            borrower : v0,
            value    : 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_value(v12),
            period   : 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_period(v12),
            time     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<AcceptOfferEvent>(v14);
    }

    public entry fun cancel_offer<T0>(arg0: &mut Platform, arg1: &mut 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg2: &mut 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::LendingSortedOffersStorage, arg3: 0x1::ascii::String, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::borrow_collection<T0>(arg1, arg3);
        let v2 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::remove_offer<T0>(v1, arg4);
        assert!(!0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::check_offer_active_status(&v2, arg5), 2);
        assert!(0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_owner(&v2) == v0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::split_collection_balance<T0>(v1, 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_value_from_collection<T0>(arg1, arg3, arg4), arg6), v0);
        let v3 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::destructure_offer(v2);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::remove(arg2, arg3, v3);
        let v4 = CancelOfferEvent{
            id         : v3,
            collection : arg3,
            creator    : v0,
            time       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CancelOfferEvent>(v4);
    }

    fun check_version(arg0: &Platform) {
        assert!(arg0.version == 1, 1);
    }

    entry fun claim_offer<T0, T1: store + key>(arg0: &Platform, arg1: &mut 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::read_collection<T0>(arg1, arg2);
        let v1 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::read_offer<T0>(v0, arg3);
        assert!(0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_is_repaid(v1) || 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::check_offer_finished_status(v1, arg4), 2);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_collection_interest<T0>(v0);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_value(v1);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_is_repaid(v1);
        assert!(!0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_is_claimed(v1), 5);
        let v2 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::borrow_offer<T0>(0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::borrow_collection<T0>(arg1, arg2), arg3);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::set_offer_as_claimed(v2);
        let (_, v4, v5, v6, v7, v8) = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::remove_kiosk_data<T1>(v2, arg5);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::close_kiosk<T1>(v4, v5, v6, v7, v8, 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_owner(v1), arg5);
    }

    entry fun create_collection<T0, T1: store + key>(arg0: &AdminCap, arg1: &Platform, arg2: &mut 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg3: &mut 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::LendingSortedOffersStorage, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::create_collection_node(arg3, arg4, arg9);
        let v0 = CreateCollectionEvent{
            id       : 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::create_collection<T0, T1>(arg2, arg4, arg5, arg6, arg7, arg9),
            interest : arg6,
            name     : arg4,
            url      : arg5,
            time     : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<CreateCollectionEvent>(v0);
    }

    entry fun create_offer<T0>(arg0: &Platform, arg1: &mut 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg2: &mut 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::LendingSortedOffersStorage, arg3: 0x1::ascii::String, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x2::tx_context::sender(arg6);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::insert<T0>(arg2, arg1, arg3, 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::create_offer<T0>(arg1, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6), 0x2::coin::value<T0>(&arg4), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>());
    }

    public fun get_my_loans_paginated<T0>(arg0: &0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg1: &0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::LendingSortedOffersStorage, arg2: 0x1::ascii::String, arg3: address, arg4: 0x1::option::Option<u8>, arg5: 0x1::option::Option<0x2::object::ID>) : vector<0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::OfferResponse> {
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::get_offers_paginated_<T0>(arg1, arg0, arg2, 0x1::option::none<address>(), 0x1::option::some<address>(arg3), 0x1::option::none<bool>(), 0x1::option::none<bool>(), 0x1::option::none<bool>(), arg4, arg5)
    }

    public fun get_my_offers_paginated<T0>(arg0: &0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg1: &0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::LendingSortedOffersStorage, arg2: 0x1::ascii::String, arg3: address, arg4: 0x1::option::Option<u8>, arg5: 0x1::option::Option<0x2::object::ID>) : vector<0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::OfferResponse> {
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::get_offers_paginated_<T0>(arg1, arg0, arg2, 0x1::option::some<address>(arg3), 0x1::option::none<address>(), 0x1::option::none<bool>(), 0x1::option::none<bool>(), 0x1::option::none<bool>(), arg4, arg5)
    }

    public fun get_offers_paginated<T0>(arg0: &0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg1: &0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::LendingSortedOffersStorage, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<u8>, arg4: 0x1::option::Option<0x2::object::ID>) : vector<0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::OfferResponse> {
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::get_offers_paginated_<T0>(arg1, arg0, arg2, 0x1::option::none<address>(), 0x1::option::none<address>(), 0x1::option::none<bool>(), 0x1::option::none<bool>(), 0x1::option::none<bool>(), arg3, arg4)
    }

    public fun get_seeking_offers_paginated<T0>(arg0: &0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg1: &0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::LendingSortedOffersStorage, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<u8>, arg4: 0x1::option::Option<0x2::object::ID>) : vector<0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::OfferResponse> {
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_sorted_offers::get_offers_paginated_<T0>(arg1, arg0, arg2, 0x1::option::none<address>(), 0x1::option::none<address>(), 0x1::option::some<bool>(false), 0x1::option::some<bool>(false), 0x1::option::some<bool>(false), arg3, arg4)
    }

    fun init(arg0: LENDING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Platform{
            id           : 0x2::object::new(arg1),
            publisher    : 0x2::package::claim<LENDING>(arg0, arg1),
            admin_cap_id : 0x2::object::uid_to_inner(&v0.id),
            version      : 1,
        };
        0x2::transfer::share_object<Platform>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun repayment_offer<T0, T1: store + key>(arg0: &Platform, arg1: &mut 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::read_offer<T0>(0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::read_collection<T0>(arg1, arg2), arg3);
        let v2 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_interest(v1);
        let v3 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_owner(v1);
        let v4 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_value(v1);
        let v5 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::get_offer_period(v1);
        assert!(0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::check_offer_active_status(v1, arg5), 3);
        let v6 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::borrow_collection<T0>(arg1, arg2);
        assert!(0x2::coin::value<T0>(&arg4) == v4 + v4 * v2 / 100, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v3);
        let v7 = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::borrow_offer<T0>(v6, arg3);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::set_offer_as_paid(v7);
        let (v8, v9, v10, v11, v12, v13) = 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::remove_kiosk_data<T1>(v7, arg6);
        assert!(v8 == v0, 7);
        0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::close_kiosk<T1>(v9, v10, v11, v12, v13, v0, arg6);
        let v14 = RepaymentEvent{
            offer_id : 0x2::object::id<0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::lending_storage::Offer>(v7),
            creator  : v3,
            borrower : v0,
            value    : v4,
            period   : v5,
            time     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RepaymentEvent>(v14);
    }

    // decompiled from Move bytecode v6
}

