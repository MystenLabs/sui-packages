module 0xe50387176587c707c428c537b7b8fb530c3eaeadd16a45b1d975369f372dbc0a::marketplace {
    struct ListingRegistry has key {
        id: 0x2::object::UID,
        listings: 0x2::bag::Bag,
        treasury: address,
        fee_bps: u64,
        admin_cap_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct ListingRecord has drop, store {
        item_type: 0x1::type_name::TypeName,
        kiosk_id: 0x2::object::ID,
        seller: address,
        price: u64,
        listed_at_ms: u64,
    }

    struct ListingCreated has copy, drop {
        item_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
        kiosk_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct ListingClosed has copy, drop {
        item_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
        kiosk_id: 0x2::object::ID,
        seller: address,
    }

    struct SaleExecuted has copy, drop {
        item_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
        kiosk_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        drip_fee: u64,
    }

    struct FeeBpsUpdated has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct TreasuryUpdated has copy, drop {
        old_addr: address,
        new_addr: address,
    }

    public fun delist<T0: store + key>(arg0: &mut ListingRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID) {
        0x2::kiosk::delist<T0>(arg1, arg2, arg3);
        if (0x2::bag::contains<0x2::object::ID>(&arg0.listings, arg3)) {
            let ListingRecord {
                item_type    : v0,
                kiosk_id     : v1,
                seller       : v2,
                price        : _,
                listed_at_ms : _,
            } = 0x2::bag::remove<0x2::object::ID, ListingRecord>(&mut arg0.listings, arg3);
            let v5 = ListingClosed{
                item_id   : arg3,
                item_type : v0,
                kiosk_id  : v1,
                seller    : v2,
            };
            0x2::event::emit<ListingClosed>(v5);
        };
    }

    public fun list<T0: store + key>(arg0: &mut ListingRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x2::kiosk::list<T0>(arg1, arg2, arg3, arg4);
        let v0 = ListingRecord{
            item_type    : 0x1::type_name::with_defining_ids<T0>(),
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            seller       : 0x2::tx_context::sender(arg6),
            price        : arg4,
            listed_at_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::bag::add<0x2::object::ID, ListingRecord>(&mut arg0.listings, arg3, v0);
        let v1 = ListingCreated{
            item_id   : arg3,
            item_type : 0x1::type_name::with_defining_ids<T0>(),
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            seller    : 0x2::tx_context::sender(arg6),
            price     : arg4,
        };
        0x2::event::emit<ListingCreated>(v1);
    }

    public fun buy<T0: store + key>(arg0: &mut ListingRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.listings, arg2), 1);
        let v0 = 0x2::bag::remove<0x2::object::ID, ListingRecord>(&mut arg0.listings, arg2);
        let v1 = v0.price;
        let v2 = v1 * arg0.fee_bps / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v1 + v2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2, arg4), arg0.treasury);
        let (v3, v4) = 0x2::kiosk::purchase<T0>(arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg4));
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let ListingRecord {
            item_type    : v5,
            kiosk_id     : v6,
            seller       : v7,
            price        : _,
            listed_at_ms : _,
        } = v0;
        let v10 = SaleExecuted{
            item_id   : arg2,
            item_type : v5,
            kiosk_id  : v6,
            seller    : v7,
            buyer     : 0x2::tx_context::sender(arg4),
            price     : v1,
            drip_fee  : v2,
        };
        0x2::event::emit<SaleExecuted>(v10);
        (v3, v4)
    }

    public fun fee_bps(arg0: &ListingRegistry) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = ListingRegistry{
            id           : v0,
            listings     : 0x2::bag::new(arg0),
            treasury     : @0x1a4c3e81ef4055af3ecf16d2f7c2ee34dd7406555716c9f32f4b75954f581490,
            fee_bps      : 200,
            admin_cap_id : 0x2::object::uid_to_inner(&v1),
        };
        let v3 = AdminCap{
            id          : v1,
            registry_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::share_object<ListingRegistry>(v2);
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun is_listed(arg0: &ListingRegistry, arg1: 0x2::object::ID) : bool {
        0x2::bag::contains<0x2::object::ID>(&arg0.listings, arg1)
    }

    public fun listing_price(arg0: &ListingRegistry, arg1: 0x2::object::ID) : u64 {
        0x2::bag::borrow<0x2::object::ID, ListingRecord>(&arg0.listings, arg1).price
    }

    public fun listing_seller(arg0: &ListingRegistry, arg1: 0x2::object::ID) : address {
        0x2::bag::borrow<0x2::object::ID, ListingRecord>(&arg0.listings, arg1).seller
    }

    public fun relist<T0: store + key>(arg0: &mut ListingRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        delist<T0>(arg0, arg1, arg2, arg3);
        list<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun treasury(arg0: &ListingRegistry) : address {
        arg0.treasury
    }

    public fun update_fee_bps(arg0: &mut ListingRegistry, arg1: &AdminCap, arg2: u64) {
        assert!(arg1.registry_id == 0x2::object::id<ListingRegistry>(arg0), 4);
        assert!(arg2 <= 1000, 3);
        arg0.fee_bps = arg2;
        let v0 = FeeBpsUpdated{
            old_bps : arg0.fee_bps,
            new_bps : arg2,
        };
        0x2::event::emit<FeeBpsUpdated>(v0);
    }

    public fun update_treasury(arg0: &mut ListingRegistry, arg1: &AdminCap, arg2: address) {
        assert!(arg1.registry_id == 0x2::object::id<ListingRegistry>(arg0), 4);
        arg0.treasury = arg2;
        let v0 = TreasuryUpdated{
            old_addr : arg0.treasury,
            new_addr : arg2,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

