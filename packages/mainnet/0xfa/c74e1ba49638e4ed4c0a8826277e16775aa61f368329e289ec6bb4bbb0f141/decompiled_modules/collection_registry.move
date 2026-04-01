module 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry {
    struct CollectionInfo has copy, drop, store {
        collection_id: 0x2::object::ID,
        name: vector<u8>,
        creator: address,
        verified: bool,
        royalty_bps: u16,
        total_listings: u64,
        total_volume: u64,
        floor_price: u64,
        registered_at: u64,
    }

    struct CollectionRegistry has store {
        collections: 0x2::table::Table<0x2::object::ID, CollectionInfo>,
        verified_collections: 0x2::table::Table<0x2::object::ID, bool>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : CollectionRegistry {
        CollectionRegistry{
            collections          : 0x2::table::new<0x2::object::ID, CollectionInfo>(arg0),
            verified_collections : 0x2::table::new<0x2::object::ID, bool>(arg0),
        }
    }

    public fun collection_id(arg0: &CollectionInfo) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun creator(arg0: &CollectionInfo) : address {
        arg0.creator
    }

    public(friend) fun decrement_total_listings(arg0: &mut CollectionRegistry, arg1: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CollectionInfo>(&mut arg0.collections, arg1);
        if (v0.total_listings > 0) {
            v0.total_listings = v0.total_listings - 1;
        };
    }

    public fun floor_price(arg0: &CollectionInfo) : u64 {
        arg0.floor_price
    }

    public fun get_collection_info(arg0: &CollectionRegistry, arg1: 0x2::object::ID) : CollectionInfo {
        assert!(0x2::table::contains<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1), 0);
        *0x2::table::borrow<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1)
    }

    public fun get_collection_royalty_bps(arg0: &CollectionRegistry, arg1: 0x2::object::ID) : u16 {
        if (!0x2::table::contains<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1)) {
            return 0
        };
        0x2::table::borrow<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1).royalty_bps
    }

    public(friend) fun increment_total_listings(arg0: &mut CollectionRegistry, arg1: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CollectionInfo>(&mut arg0.collections, arg1);
        v0.total_listings = v0.total_listings + 1;
    }

    public fun is_collection_registered(arg0: &CollectionRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1)
    }

    public fun is_collection_verified(arg0: &CollectionRegistry, arg1: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1)) {
            return false
        };
        0x2::table::borrow<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1).verified
    }

    public fun name(arg0: &CollectionInfo) : vector<u8> {
        arg0.name
    }

    public(friend) fun register_collection(arg0: &mut CollectionRegistry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: address, arg4: u16, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1), 1);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = CollectionInfo{
            collection_id  : arg1,
            name           : arg2,
            creator        : arg3,
            verified       : false,
            royalty_bps    : arg4,
            total_listings : 0,
            total_volume   : 0,
            floor_price    : 0,
            registered_at  : v0,
        };
        0x2::table::add<0x2::object::ID, CollectionInfo>(&mut arg0.collections, arg1, v1);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_collection_registered(arg1, arg2, false, v0);
    }

    public fun registered_at(arg0: &CollectionInfo) : u64 {
        arg0.registered_at
    }

    public fun royalty_bps(arg0: &CollectionInfo) : u16 {
        arg0.royalty_bps
    }

    public(friend) fun set_collection_verified(arg0: &mut CollectionRegistry, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1), 0);
        0x2::table::borrow_mut<0x2::object::ID, CollectionInfo>(&mut arg0.collections, arg1).verified = arg2;
        if (arg2) {
            if (!0x2::table::contains<0x2::object::ID, bool>(&arg0.verified_collections, arg1)) {
                0x2::table::add<0x2::object::ID, bool>(&mut arg0.verified_collections, arg1, true);
            };
        } else if (0x2::table::contains<0x2::object::ID, bool>(&arg0.verified_collections, arg1)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg0.verified_collections, arg1);
        };
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_collection_verification_updated(arg1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun total_listings(arg0: &CollectionInfo) : u64 {
        arg0.total_listings
    }

    public fun total_volume(arg0: &CollectionInfo) : u64 {
        arg0.total_volume
    }

    public(friend) fun update_collection_stats(arg0: &mut CollectionRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        if (!0x2::table::contains<0x2::object::ID, CollectionInfo>(&arg0.collections, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CollectionInfo>(&mut arg0.collections, arg1);
        v0.total_volume = v0.total_volume + arg2;
        v0.floor_price = arg3;
    }

    public fun verified(arg0: &CollectionInfo) : bool {
        arg0.verified
    }

    // decompiled from Move bytecode v6
}

