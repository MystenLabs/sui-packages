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

    public(friend) fun is_empty(arg0: &PriceFeed) : bool {
        0x2::vec_map::is_empty<0x2::object::ID, PriceInfo>(&arg0.prices)
    }

    fun collect_price_updates(arg0: &mut PriceFeed, arg1: &0x2::clock::Clock, arg2: vector<u8>) : vector<PriceInfoUpdate> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::bcs::new(arg2);
        let v2 = 0x2::bcs::peel_vec_length(&mut v1);
        assert!(v2 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_price_feed_data());
        let v3 = 0x1::vector::empty<PriceInfoUpdate>();
        let v4 = 0;
        while (v4 < v2) {
            let v5 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1));
            let v6 = 0x2::bcs::peel_u128(&mut v1) / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
            let v7 = 0x2::bcs::peel_u64(&mut v1);
            assert!(v7 <= v0 + 1500, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::price_feed_timestamp_in_future());
            let v8 = if (v7 > v0) {
                0
            } else {
                v0 - v7
            };
            assert!(v8 <= 60000, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::price_feed_timestamp_too_stale());
            let (v9, v10) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, PriceInfo>(&mut arg0.prices, (0x2::bcs::peel_u16(&mut v1) as u64));
            assert!(&v5 == v9, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::price_feed_registry_perp_mismatch());
            assert!(v7 >= v10.timestamp, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::price_feed_timestamp_not_monotonic());
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

    public(friend) fun get_price(arg0: &PriceFeed, arg1: &0x2::object::ID) : u128 {
        0x2::vec_map::get<0x2::object::ID, PriceInfo>(&arg0.prices, arg1).price
    }

    public(friend) fun get_price_info(arg0: &PriceFeed, arg1: &0x2::object::ID) : &PriceInfo {
        0x2::vec_map::get<0x2::object::ID, PriceInfo>(&arg0.prices, arg1)
    }

    public(friend) fun get_prices_map(arg0: &PriceFeed) : &0x2::vec_map::VecMap<0x2::object::ID, PriceInfo> {
        &arg0.prices
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

    public(friend) fun price_info_perp_id(arg0: &PriceInfo) : &0x2::object::ID {
        &arg0.perp_id
    }

    public(friend) fun price_info_price(arg0: &PriceInfo) : u128 {
        arg0.price
    }

    public(friend) fun price_info_timestamp(arg0: &PriceInfo) : u64 {
        arg0.timestamp
    }

    public(friend) fun set_feeder(arg0: &mut PriceFeed, arg1: address) {
        assert!(arg1 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        arg0.feeder = arg1;
    }

    public(friend) fun share_price_feed(arg0: PriceFeed) {
        0x2::transfer::share_object<PriceFeed>(arg0);
    }

    public(friend) fun size(arg0: &PriceFeed) : u64 {
        0x2::vec_map::length<0x2::object::ID, PriceInfo>(&arg0.prices)
    }

    public(friend) fun to_vectors(arg0: &PriceFeed) : (vector<0x2::object::ID>, vector<u128>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0;
        while (v2 < 0x2::vec_map::length<0x2::object::ID, PriceInfo>(&arg0.prices)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, PriceInfo>(&arg0.prices, v2);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v3);
            0x1::vector::push_back<u128>(&mut v1, v4.price);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun update_price_feed(arg0: &mut PriceFeed, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = arg0.feeder;
        assert!(v0 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_price_feeder());
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::verify_signature(arg3, arg4, arg2);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_result_status(v1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_price_feed_signature());
        let v2 = 0x1::vector::pop_back<u8>(&mut arg3);
        assert!(v2 == 0 || v2 == 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_price_feed_signature());
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_public_address(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_result_public_key(v1)) == v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_price_feed_signature());
        emit_price_feed_update_event(collect_price_updates(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

