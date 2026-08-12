module 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::listings {
    struct LISTINGS has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        fee_bps: u64,
        sponsor_price: u64,
        max_sponsored_listings: u64,
        balances: 0x2::bag::Bag,
    }

    struct SimpleListing<phantom T0, phantom T1> has store, key {
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

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CreateSimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct CancelSimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct RelistSimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        new_price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct BuySimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
        royalty: u64,
        fee: u64,
        seller: address,
        buyer: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
        maybe_buyer_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct AddSponsoredListingEvent has copy, drop {
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        nft_type: 0x1::ascii::String,
        period: u64,
        seller: address,
        expire_at: u64,
    }

    public fun add_sponsored_listing<T0: store + key, T1>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg2), 3);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) == arg3 * arg0.sponsor_price, 4);
        deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4));
        let v0 = type_string<T0>();
        if (!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&arg0.id, v0)) {
            let v1 = SimpleSponsoredCollection<T0>{
                id       : 0x2::object::new(arg5),
                listings : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            };
            0x2::dynamic_object_field::add<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, v0, v1);
        } else {
            remove_expired_sponsored_listings<T0>(arg0, arg1);
        };
        let v2 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, v0).listings;
        let v3 = if (0x2::vec_map::contains<0x2::object::ID, u64>(v2, &arg2)) {
            let (_, v5) = 0x2::vec_map::remove<0x2::object::ID, u64>(v2, &arg2);
            let v6 = v5 + arg3 * 86400000;
            0x2::vec_map::insert<0x2::object::ID, u64>(v2, arg2, v6);
            v6
        } else {
            assert!(0x2::vec_map::length<0x2::object::ID, u64>(v2) < arg0.max_sponsored_listings, 5);
            let v7 = 0x2::clock::timestamp_ms(arg1) + arg3 * 86400000;
            0x2::vec_map::insert<0x2::object::ID, u64>(v2, arg2, v7);
            v7
        };
        let v8 = AddSponsoredListingEvent{
            nft_id    : arg2,
            coin_type : type_string<T1>(),
            nft_type  : v0,
            period    : arg3,
            seller    : 0x2::dynamic_object_field::borrow<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg2).seller,
            expire_at : v3,
        };
        0x2::event::emit<AddSponsoredListingEvent>(v8);
    }

    public fun buy_listing_with_transfer_policy<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: address, arg5: 0x2::object::ID, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: &mut 0x3d6bde09785d97970f9f12c399540f470ffa26f5f34a9dc1e0474882f0bf6750::royalty_vault::RoyaltyVault<T0, T1>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        verify_version(arg0);
        assert!(0x1::type_name::with_defining_ids<T1>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 6);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg5), 3);
        remove_sponsored_listing_if_exists<T0>(arg0, arg5);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, SimpleListing<T0, T1>>(&mut arg0.id, arg5);
        let SimpleListing {
            id                    : v1,
            type                  : v2,
            nft_id                : v3,
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        } = v0;
        0x2::object::delete(v1);
        let v7 = 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::royalty_amount<T0>(arg7, v4);
        let v8 = market_fee(arg0, v4);
        assert!(0x2::coin::value<T1>(arg6) >= v4 + v7 + v8, 4);
        let (v9, v10) = 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::zero_purchase<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, arg5), arg7, arg9);
        let v11 = v10;
        0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::place_or_lock<T0>(arg7, &mut v11, v9, arg2, arg3);
        deposit<T1>(arg0, 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::settle_payment<T0, T1>(arg6, arg8, arg7, v5, v4, v7, v8, arg9));
        let v12 = BuySimpleListingEvent{
            type                  : v2,
            nft_id                : v3,
            coin_type             : type_string<T1>(),
            price                 : v4,
            royalty               : v7,
            fee                   : v8,
            seller                : v5,
            buyer                 : arg4,
            maybe_seller_kiosk_id : v6,
            maybe_buyer_kiosk_id  : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg2)),
        };
        0x2::event::emit<BuySimpleListingEvent>(v12);
        v11
    }

    public fun buy_listing_without_transfer_policy<T0: store + key, T1>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg1), 3);
        remove_sponsored_listing_if_exists<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, SimpleListing<T0, T1>>(&mut arg0.id, arg1);
        let SimpleListing {
            id                    : v2,
            type                  : v3,
            nft_id                : v4,
            price                 : v5,
            seller                : v6,
            maybe_seller_kiosk_id : v7,
        } = v1;
        0x2::object::delete(v2);
        let v8 = market_fee(arg0, v5);
        assert!(0x2::coin::value<T1>(arg2) >= v5 + v8, 4);
        deposit<T1>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v8, arg3)));
        0x2::coin::send_funds<T1>(0x2::coin::split<T1>(arg2, v5, arg3), v6);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut v1.id, arg1), v0);
        let v9 = BuySimpleListingEvent{
            type                  : v3,
            nft_id                : v4,
            coin_type             : type_string<T1>(),
            price                 : v5,
            royalty               : 0,
            fee                   : v8,
            seller                : v6,
            buyer                 : v0,
            maybe_seller_kiosk_id : v7,
            maybe_buyer_kiosk_id  : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<BuySimpleListingEvent>(v9);
    }

    public fun cancel_listing_with_transfer_policy<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg3), 3);
        remove_sponsored_listing_if_exists<T0>(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, SimpleListing<T0, T1>>(&mut arg0.id, arg3);
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
            coin_type             : type_string<T1>(),
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        };
        0x2::event::emit<CancelSimpleListingEvent>(v7);
    }

    public fun cancel_listing_without_transfer_policy<T0: store + key, T1>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg1), 3);
        remove_sponsored_listing_if_exists<T0>(arg0, arg1);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, SimpleListing<T0, T1>>(&mut arg0.id, arg1);
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
            coin_type             : type_string<T1>(),
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        };
        0x2::event::emit<CancelSimpleListingEvent>(v7);
    }

    public fun create_listing_with_transfer_policy<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 1;
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            arg6
        } else {
            assert!(arg4 == 0x2::tx_context::sender(arg7), 2);
            0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::assert_settleable<T0>(arg3);
            assert!(0x3d6bde09785d97970f9f12c399540f470ffa26f5f34a9dc1e0474882f0bf6750::royalty_vault::has_vault<T0, T1>(arg3), 8);
            0
        };
        let v3 = SimpleListing<T0, T1>{
            id                    : 0x2::object::new(arg7),
            type                  : v0,
            nft_id                : arg5,
            price                 : arg6,
            seller                : arg4,
            maybe_seller_kiosk_id : 0x1::option::some<0x2::object::ID>(v1),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v3.id, arg5, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg5, v2, arg7));
        0x2::dynamic_object_field::add<0x2::object::ID, SimpleListing<T0, T1>>(&mut arg0.id, arg5, v3);
        let v4 = CreateSimpleListingEvent{
            type                  : v0,
            nft_id                : arg5,
            coin_type             : type_string<T1>(),
            price                 : arg6,
            seller                : arg4,
            maybe_seller_kiosk_id : 0x1::option::some<0x2::object::ID>(v1),
        };
        0x2::event::emit<CreateSimpleListingEvent>(v4);
    }

    public fun create_listing_without_transfer_policy<T0: store + key, T1>(arg0: &mut Store, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        let v2 = 0x2::object::id<T0>(&arg1);
        let v3 = SimpleListing<T0, T1>{
            id                    : 0x2::object::new(arg3),
            type                  : v1,
            nft_id                : v2,
            price                 : arg2,
            seller                : v0,
            maybe_seller_kiosk_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut v3.id, v2, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, SimpleListing<T0, T1>>(&mut arg0.id, v2, v3);
        let v4 = CreateSimpleListingEvent{
            type                  : v1,
            nft_id                : v2,
            coin_type             : type_string<T1>(),
            price                 : arg2,
            seller                : v0,
            maybe_seller_kiosk_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<CreateSimpleListingEvent>(v4);
    }

    fun deposit<T0>(arg0: &mut Store, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
    }

    public fun get_balance_amount<T0>(arg0: &Store) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun get_listing_price_with_transfer_policy<T0: store + key, T1>(arg0: &Store, arg1: 0x2::object::ID, arg2: &0x2::transfer_policy::TransferPolicy<T0>) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg1), 3);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg1);
        v0.price + market_fee(arg0, v0.price) + 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers::royalty_amount<T0>(arg2, v0.price)
    }

    public fun get_listing_price_without_transfer_policy<T0: store + key, T1>(arg0: &Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg1), 3);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg1);
        v0.price + market_fee(arg0, v0.price)
    }

    fun init(arg0: LISTINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id                     : 0x2::object::new(arg1),
            version                : 1,
            admin                  : 0x2::tx_context::sender(arg1),
            fee_bps                : 300,
            sponsor_price          : 20000000,
            max_sponsored_listings : 3,
            balances               : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    fun market_fee(arg0: &Store, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.fee_bps as u128) / 10000) as u64)
    }

    public fun relist_listing_with_transfer_policy<T0: store + key, T1>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg3), 3);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg3);
        assert!(0x2::kiosk::has_access(arg1, arg2), 2);
        assert!(v0.type == 1, 7);
        let v1 = if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            arg4
        } else {
            0
        };
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SimpleListing<T0, T1>>(&mut arg0.id, arg3);
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v2.id, arg3));
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v2.id, arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, v1, arg5));
        v2.price = arg4;
        let v3 = RelistSimpleListingEvent{
            type                  : v2.type,
            nft_id                : arg3,
            coin_type             : type_string<T1>(),
            new_price             : arg4,
            seller                : v2.seller,
            maybe_seller_kiosk_id : v2.maybe_seller_kiosk_id,
        };
        0x2::event::emit<RelistSimpleListingEvent>(v3);
    }

    public fun relist_listing_without_transfer_policy<T0: store + key, T1>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg1), 3);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SimpleListing<T0, T1>>(&arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.seller, 2);
        assert!(v0.type == 0, 7);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SimpleListing<T0, T1>>(&mut arg0.id, arg1);
        v1.price = arg2;
        let v2 = RelistSimpleListingEvent{
            type                  : v1.type,
            nft_id                : arg1,
            coin_type             : type_string<T1>(),
            new_price             : arg2,
            seller                : v1.seller,
            maybe_seller_kiosk_id : v1.maybe_seller_kiosk_id,
        };
        0x2::event::emit<RelistSimpleListingEvent>(v2);
    }

    fun remove_expired_sponsored_listings<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock) {
        let v0 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, type_string<T0>()).listings;
        let v1 = 0x2::vec_map::keys<0x2::object::ID, u64>(v0);
        while (!0x1::vector::is_empty<0x2::object::ID>(&v1)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut v1);
            if (*0x2::vec_map::get<0x2::object::ID, u64>(v0, &v2) < 0x2::clock::timestamp_ms(arg1)) {
                let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(v0, &v2);
            };
        };
    }

    fun remove_sponsored_listing_if_exists<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID) {
        let v0 = type_string<T0>();
        if (!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&arg0.id, v0)) {
            return
        };
        let v1 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, v0).listings;
        if (0x2::vec_map::contains<0x2::object::ID, u64>(v1, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(v1, &arg1);
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

    fun type_string<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x1::type_name::as_string(&v0)
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version <= 1, 1);
    }

    entry fun withdraw_balance<T0>(arg0: &mut Store, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0), 4);
        let v1 = if (arg1 == 0) {
            0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0))
        } else {
            0x2::balance::split<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1)
        };
        0x2::balance::send_funds<T0>(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

