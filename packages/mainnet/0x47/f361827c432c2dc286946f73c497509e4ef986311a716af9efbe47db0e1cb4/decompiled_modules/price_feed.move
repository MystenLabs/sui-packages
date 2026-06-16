module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed {
    struct PriceInfo has copy, drop, store {
        perp_id: 0x2::object::ID,
        price: u128,
        timestamp: u64,
    }

    struct PriceFeed has key {
        id: 0x2::object::UID,
        feeder: address,
        prices: 0x2::vec_map::VecMap<0x2::object::ID, PriceInfo>,
    }

    struct PriceInfoUpdate has copy, drop {
        perp_id: 0x2::object::ID,
        price: u128,
        timestamp: u64,
    }

    struct PriceFeedUpdateEvent has copy, drop {
        updates: vector<PriceInfoUpdate>,
        updated_count: u64,
    }

    public(friend) fun contains(arg0: &PriceFeed, arg1: &0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, PriceInfo>(&arg0.prices, arg1)
    }

    fun collect_price_updates(arg0: &mut PriceFeed, arg1: &0x2::clock::Clock, arg2: vector<u8>) : vector<PriceInfoUpdate> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::bcs::new(arg2);
        let v2 = 0x2::bcs::peel_vec_length(&mut v1);
        assert!(v2 > 0, 909);
        let v3 = 0x1::vector::empty<PriceInfoUpdate>();
        let v4 = 0;
        while (v4 < v2) {
            let v5 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1));
            let v6 = 0x2::bcs::peel_u128(&mut v1) / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
            let v7 = 0x2::bcs::peel_u64(&mut v1);
            assert!(v7 <= v0 + 1500, 912);
            let v8 = if (v7 > v0) {
                0
            } else {
                v0 - v7
            };
            assert!(v8 <= 60000, 913);
            let (v9, v10) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, PriceInfo>(&mut arg0.prices, (0x2::bcs::peel_u16(&mut v1) as u64));
            assert!(&v5 == v9, 914);
            assert!(v7 >= v10.timestamp, 915);
            v10.price = v6;
            v10.timestamp = v7;
            let v11 = PriceInfoUpdate{
                perp_id   : v5,
                price     : v6,
                timestamp : v7,
            };
            0x1::vector::push_back<PriceInfoUpdate>(&mut v3, v11);
            v4 = v4 + 1;
        };
        v3
    }

    fun emit_price_feed_update_event(arg0: vector<PriceInfoUpdate>) {
        let v0 = PriceFeedUpdateEvent{
            updates       : arg0,
            updated_count : 0x1::vector::length<PriceInfoUpdate>(&arg0),
        };
        0x2::event::emit<PriceFeedUpdateEvent>(v0);
    }

    public fun feeder(arg0: &PriceFeed) : address {
        arg0.feeder
    }

    public(friend) fun get_price_info(arg0: &PriceFeed, arg1: &0x2::object::ID) : &PriceInfo {
        0x2::vec_map::get<0x2::object::ID, PriceInfo>(&arg0.prices, arg1)
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        share_price_feed(new_for_migration(arg0));
    }

    public(friend) fun insert_price_info(arg0: &mut PriceFeed, arg1: 0x2::object::ID, arg2: u128, arg3: u64) {
        let v0 = PriceInfo{
            perp_id   : arg1,
            price     : arg2,
            timestamp : arg3,
        };
        0x2::vec_map::insert<0x2::object::ID, PriceInfo>(&mut arg0.prices, arg1, v0);
    }

    public(friend) fun new_for_migration(arg0: &mut 0x2::tx_context::TxContext) : PriceFeed {
        PriceFeed{
            id     : 0x2::object::new(arg0),
            feeder : @0x0,
            prices : 0x2::vec_map::empty<0x2::object::ID, PriceInfo>(),
        }
    }

    public(friend) fun price_info_price(arg0: &PriceInfo) : u128 {
        arg0.price
    }

    public(friend) fun price_info_timestamp(arg0: &PriceInfo) : u64 {
        arg0.timestamp
    }

    public(friend) fun set_feeder(arg0: &mut PriceFeed, arg1: address) {
        assert!(arg1 != @0x0, 105);
        arg0.feeder = arg1;
    }

    public(friend) fun share_price_feed(arg0: PriceFeed) {
        0x2::transfer::share_object<PriceFeed>(arg0);
    }

    public fun update_price_feed(arg0: &mut PriceFeed, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = arg0.feeder;
        assert!(v0 != @0x0, 910);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::library::signature_scheme(&arg3);
        assert!(v1 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::library::scheme_secp256k1() || v1 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::library::scheme_ed25519(), 908);
        let v2 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::library::recover_signer_address(arg3, arg4, arg2, 908);
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v2) == v0, 908);
        emit_price_feed_update_event(collect_price_updates(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v7
}

