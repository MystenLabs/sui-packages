module 0xff2251ea99230ed1cbe3a347a209352711c6723fcdcd9286e16636e65bb55cab::tradeport_listings {
    struct TRADEPORT_LISTINGS has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        fee_bps: u64,
        sponsor_price: u64,
        max_sponsored_listings: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        usdc_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct SimpleListing<phantom T0> has store, key {
        id: 0x2::object::UID,
        type: u64,
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct SimpleSponsoredCollection<phantom T0> has store, key {
        id: 0x2::object::UID,
        listings: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
    }

    struct CreateSimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct CancelSimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct RelistSimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        new_price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct BuySimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
        maybe_buyer_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct AddSponsoredListingEvent has copy, drop {
        nft_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        period: u64,
        seller: address,
        expire_at: u64,
    }

    public fun add_sponsored_listing<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0>>(&arg0.id, arg2), 3);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) == arg3 * arg0.sponsor_price, 4);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = *0x1::type_name::as_string(&v0);
        if (!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&arg0.id, v1)) {
            let v2 = SimpleSponsoredCollection<T0>{
                id       : 0x2::object::new(arg5),
                listings : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            };
            0x2::dynamic_object_field::add<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, v1, v2);
        } else {
            remove_expired_sponsored_listings<T0>(arg0, arg1);
        };
        let v3 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, v1).listings;
        let v4 = if (0x2::vec_map::contains<0x2::object::ID, u64>(v3, &arg2)) {
            let (_, v6) = 0x2::vec_map::remove<0x2::object::ID, u64>(v3, &arg2);
            let v7 = v6 + arg3 * 86400000;
            0x2::vec_map::insert<0x2::object::ID, u64>(v3, arg2, v7);
            v7
        } else {
            assert!(0x2::vec_map::length<0x2::object::ID, u64>(v3) < arg0.max_sponsored_listings, 5);
            let v8 = 0x2::clock::timestamp_ms(arg1) + arg3 * 86400000;
            0x2::vec_map::insert<0x2::object::ID, u64>(v3, arg2, v8);
            v8
        };
        let v9 = AddSponsoredListingEvent{
            nft_id    : arg2,
            nft_type  : v1,
            period    : arg3,
            seller    : 0x2::tx_context::sender(arg5),
            expire_at : v4,
        };
        0x2::event::emit<AddSponsoredListingEvent>(v9);
    }

    public fun buy_listing_with_transfer_policy<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        remove_sponsored_listing_if_exists<T0>(arg0, arg4);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg4);
        let SimpleListing {
            id                    : v1,
            type                  : v2,
            nft_id                : v3,
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        } = v0;
        0x2::object::delete(v1);
        let v7 = 0;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg6)) {
            v7 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg6, v4);
        };
        let v8 = (((v4 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg5) >= v4 + v7 + v8, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg5, v8, arg7)));
        let (v9, v10) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, arg4), 0x2::coin::split<0x2::sui::SUI>(arg5, v4, arg7));
        let v11 = v10;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg6)) {
            0x2::kiosk::lock<T0>(arg2, arg3, arg6, v9);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v11, arg2);
        } else {
            0x2::kiosk::place<T0>(arg2, arg3, v9);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg6)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v11, 0x2::coin::split<0x2::sui::SUI>(arg5, v7, arg7));
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg6)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg6, &mut v11);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg6)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(arg2, &mut v11);
        };
        let v12 = BuySimpleListingEvent{
            type                  : v2,
            nft_id                : v3,
            price                 : v4,
            seller                : v5,
            buyer                 : 0x2::tx_context::sender(arg7),
            maybe_seller_kiosk_id : v6,
            maybe_buyer_kiosk_id  : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg2)),
        };
        0x2::event::emit<BuySimpleListingEvent>(v12);
        v11
    }

    public fun buy_listing_without_transfer_policy<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        remove_sponsored_listing_if_exists<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg1);
        let SimpleListing {
            id                    : v2,
            type                  : v3,
            nft_id                : v4,
            price                 : v5,
            seller                : v6,
            maybe_seller_kiosk_id : v7,
        } = v1;
        0x2::object::delete(v2);
        let v8 = (((v5 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v5 + v8, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v8, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v5, arg3), v6);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut v1.id, arg1), v0);
        let v9 = BuySimpleListingEvent{
            type                  : v3,
            nft_id                : v4,
            price                 : v5,
            seller                : v6,
            buyer                 : v0,
            maybe_seller_kiosk_id : v7,
            maybe_buyer_kiosk_id  : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<BuySimpleListingEvent>(v9);
    }

    public fun cancel_listing_with_transfer_policy<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID) {
        remove_sponsored_listing_if_exists<T0>(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg3);
        assert!(0x2::kiosk::has_access(arg1, arg2), 2);
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, arg3));
        let SimpleListing {
            id                    : v1,
            type                  : v2,
            nft_id                : v3,
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        } = v0;
        0x2::object::delete(v1);
        let v7 = CancelSimpleListingEvent{
            type                  : v2,
            nft_id                : v3,
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        };
        0x2::event::emit<CancelSimpleListingEvent>(v7);
    }

    public fun cancel_listing_without_transfer_policy<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        remove_sponsored_listing_if_exists<T0>(arg0, arg1);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v0.seller, 2);
        let SimpleListing {
            id                    : v1,
            type                  : v2,
            nft_id                : v3,
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        } = v0;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut v0.id, arg1), v5);
        let v7 = CancelSimpleListingEvent{
            type                  : v2,
            nft_id                : v3,
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        };
        0x2::event::emit<CancelSimpleListingEvent>(v7);
    }

    public fun create_listing_with_transfer_policy<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 1;
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v3 = SimpleListing<T0>{
            id                    : 0x2::object::new(arg5),
            type                  : v1,
            nft_id                : arg3,
            price                 : arg4,
            seller                : v0,
            maybe_seller_kiosk_id : 0x1::option::some<0x2::object::ID>(v2),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v3.id, arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4, arg5));
        0x2::dynamic_object_field::add<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg3, v3);
        let v4 = CreateSimpleListingEvent{
            type                  : v1,
            nft_id                : arg3,
            price                 : arg4,
            seller                : v0,
            maybe_seller_kiosk_id : 0x1::option::some<0x2::object::ID>(v2),
        };
        0x2::event::emit<CreateSimpleListingEvent>(v4);
    }

    public fun create_listing_without_transfer_policy<T0: store + key>(arg0: &mut Store, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        let v2 = 0x2::object::id<T0>(&arg1);
        let v3 = SimpleListing<T0>{
            id                    : 0x2::object::new(arg3),
            type                  : v1,
            nft_id                : v2,
            price                 : arg2,
            seller                : v0,
            maybe_seller_kiosk_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut v3.id, v2, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, v2, v3);
        let v4 = CreateSimpleListingEvent{
            type                  : v1,
            nft_id                : v2,
            price                 : arg2,
            seller                : v0,
            maybe_seller_kiosk_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<CreateSimpleListingEvent>(v4);
    }

    fun init(arg0: TRADEPORT_LISTINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id                     : 0x2::object::new(arg1),
            version                : 1,
            admin                  : 0x2::tx_context::sender(arg1),
            fee_bps                : 300,
            sponsor_price          : 20000000,
            max_sponsored_listings : 3,
            sui_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            usdc_balance           : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    public fun relist_listing_with_transfer_policy<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg3);
        assert!(0x2::kiosk::has_access(arg1, arg2), 2);
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, arg3));
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4, arg5));
        v0.price = arg4;
        let v1 = RelistSimpleListingEvent{
            type                  : v0.type,
            nft_id                : arg3,
            new_price             : arg4,
            seller                : v0.seller,
            maybe_seller_kiosk_id : v0.maybe_seller_kiosk_id,
        };
        0x2::event::emit<RelistSimpleListingEvent>(v1);
    }

    public fun relist_listing_without_transfer_policy<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.seller, 2);
        v0.price = arg2;
        let v1 = RelistSimpleListingEvent{
            type                  : v0.type,
            nft_id                : arg1,
            new_price             : arg2,
            seller                : v0.seller,
            maybe_seller_kiosk_id : v0.maybe_seller_kiosk_id,
        };
        0x2::event::emit<RelistSimpleListingEvent>(v1);
    }

    fun remove_expired_sponsored_listings<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, *0x1::type_name::as_string(&v0)).listings;
        let v2 = 0x2::vec_map::keys<0x2::object::ID, u64>(v1);
        while (!0x1::vector::is_empty<0x2::object::ID>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x2::object::ID>(&mut v2);
            if (*0x2::vec_map::get<0x2::object::ID, u64>(v1, &v3) < 0x2::clock::timestamp_ms(arg1)) {
                let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(v1, &v3);
            };
        };
    }

    fun remove_sponsored_listing_if_exists<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = *0x1::type_name::as_string(&v0);
        if (!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&arg0.id, v1)) {
            return
        };
        let v2 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, v1).listings;
        if (0x2::vec_map::contains<0x2::object::ID, u64>(v2, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(v2, &arg1);
        };
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_fee_bps(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.fee_bps = arg1;
    }

    entry fun set_max_sponsored_listings(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.max_sponsored_listings = arg1;
    }

    entry fun set_sponsor_price(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.sponsor_price = arg1;
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 1, 1);
    }

    entry fun withdraw_sui_balance(arg0: &mut Store, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        let v0 = if (arg1 == 0) {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance)
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1)
        };
        if (0x2::tx_context::sender(arg3) == arg2) {
            0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), arg2);
        };
    }

    entry fun withdraw_usdc_balance(arg0: &mut Store, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        let v0 = if (arg1 == 0) {
            0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance)
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, arg1)
        };
        if (0x2::tx_context::sender(arg3) == arg2) {
            0x2::pay::keep<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg3), arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg3), arg2);
        };
    }

    // decompiled from Move bytecode v6
}

