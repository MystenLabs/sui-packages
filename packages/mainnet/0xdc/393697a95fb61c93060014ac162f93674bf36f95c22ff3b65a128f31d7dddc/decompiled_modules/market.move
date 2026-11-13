module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market {
    struct MarketRule has drop {
        dummy_field: bool,
    }

    struct RuleConfig has drop, store {
        dummy_field: bool,
    }

    struct Market has key {
        id: 0x2::object::UID,
        paused: bool,
        spice_fee_bps: u64,
        seal_fee_bps: u64,
        listings: u64,
        sales: u64,
    }

    struct Listing<phantom T0: store + key, phantom T1> has key {
        id: 0x2::object::UID,
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
        price: u64,
        cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct Listed has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        kind: u8,
        currency: 0x1::type_name::TypeName,
        price: u64,
        seller: address,
    }

    struct Delisted has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    struct Sold has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        kind: u8,
        currency: 0x1::type_name::TypeName,
        price: u64,
        fee: u64,
        seller: address,
        buyer: address,
    }

    public(friend) fun add_rule<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = MarketRule{dummy_field: false};
        let v1 = RuleConfig{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, MarketRule, RuleConfig>(v0, arg0, arg1, v1);
    }

    public fun buy<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::Revenue, arg2: Listing<T0, T1>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = fee_for<T0>(arg0, arg2.price);
        assert!(0x2::coin::value<T1>(&arg7) == arg2.price, 3);
        let Listing {
            id       : v1,
            kiosk_id : v2,
            item_id  : v3,
            seller   : v4,
            price    : v5,
            cap      : v6,
        } = arg2;
        let v7 = v1;
        assert!(v2 == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 5);
        0x2::object::delete(v7);
        if (v0 > 0) {
            0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::deposit<T1>(arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg7, v0, arg9)), arg8, arg9);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg7, v4);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v6, 0x2::coin::zero<0x2::sui::SUI>(arg9));
        let v10 = v9;
        let v11 = MarketRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, MarketRule>(v11, &mut v10);
        0x2::kiosk::lock<T0>(arg5, arg6, arg4, v8);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v10);
        arg0.sales = arg0.sales + 1;
        let v15 = Sold{
            listing_id : 0x2::object::uid_to_inner(&v7),
            item_id    : v3,
            kind       : kind<T0>(),
            currency   : 0x1::type_name::with_original_ids<T1>(),
            price      : v5,
            fee        : v0,
            seller     : v4,
            buyer      : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<Sold>(v15);
    }

    public(friend) fun create(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Market {
        Market{
            id            : 0x2::object::new(arg2),
            paused        : false,
            spice_fee_bps : arg0,
            seal_fee_bps  : arg1,
            listings      : 0,
            sales         : 0,
        }
    }

    public fun delist<T0: store + key, T1>(arg0: Listing<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg3), 4);
        assert!(arg0.kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg1) && 0x2::kiosk::has_access(arg1, arg2), 5);
        let Listing {
            id       : v0,
            kiosk_id : _,
            item_id  : v2,
            seller   : _,
            price    : _,
            cap      : v5,
        } = arg0;
        let v6 = v0;
        let v7 = Delisted{
            listing_id : 0x2::object::uid_to_inner(&v6),
            item_id    : v2,
        };
        0x2::event::emit<Delisted>(v7);
        0x2::object::delete(v6);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v5);
    }

    public fun fee_bps<T0>(arg0: &Market) : u64 {
        if (kind<T0>() == 1) {
            arg0.spice_fee_bps
        } else {
            arg0.seal_fee_bps
        }
    }

    public fun fee_for<T0>(arg0: &Market, arg1: u64) : u64 {
        (((arg1 as u128) * (fee_bps<T0>(arg0) as u128) / 10000) as u64)
    }

    public fun is_paused(arg0: &Market) : bool {
        arg0.paused
    }

    public fun item_id<T0: store + key, T1>(arg0: &Listing<T0, T1>) : 0x2::object::ID {
        arg0.item_id
    }

    public fun kind<T0>() : u8 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (v0 == 0x1::type_name::with_original_ids<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>()) {
            1
        } else {
            assert!(v0 == 0x1::type_name::with_original_ids<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SiaynoqSeal>(), 6);
            2
        }
    }

    public fun kiosk_id<T0: store + key, T1>(arg0: &Listing<T0, T1>) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun list<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 1);
        assert!(arg4 > 0, 2);
        let v0 = Listing<T0, T1>{
            id       : 0x2::object::new(arg5),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            item_id  : arg3,
            seller   : 0x2::tx_context::sender(arg5),
            price    : arg4,
            cap      : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg5),
        };
        let v1 = 0x2::object::id<Listing<T0, T1>>(&v0);
        arg0.listings = arg0.listings + 1;
        let v2 = Listed{
            listing_id : v1,
            item_id    : arg3,
            kind       : kind<T0>(),
            currency   : 0x1::type_name::with_original_ids<T1>(),
            price      : arg4,
            seller     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<Listed>(v2);
        0x2::transfer::share_object<Listing<T0, T1>>(v0);
        v1
    }

    public fun price<T0: store + key, T1>(arg0: &Listing<T0, T1>) : u64 {
        arg0.price
    }

    public fun seller<T0: store + key, T1>(arg0: &Listing<T0, T1>) : address {
        arg0.seller
    }

    public(friend) fun set_fees(arg0: &mut Market, arg1: u64, arg2: u64) {
        assert!(arg1 <= 1000 && arg2 <= 1000, 7);
        arg0.spice_fee_bps = arg1;
        arg0.seal_fee_bps = arg2;
    }

    public(friend) fun set_paused(arg0: &mut Market, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun share(arg0: Market) {
        0x2::transfer::share_object<Market>(arg0);
    }

    // decompiled from Move bytecode v7
}

