module 0x970ea798915ae13d8a85b2c09706361bc72985f5a0eb25231eccd28732fcb857::prices {
    struct Volume has store, key {
        id: 0x2::object::UID,
        usd_volume_x2decimal: u128,
        decimal_price: u64,
        decimal_coin: u64,
        pyth_price_id: vector<u8>,
    }

    struct VolumeUpdateEvent has copy, drop {
        usd_volume_x2decimal: u128,
        decimal_price: u64,
        decimal_coin: u64,
    }

    public fun add(arg0: &mut Volume, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg3, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) != arg0.pyth_price_id, 912831);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        arg0.usd_volume_x2decimal = arg0.usd_volume_x2decimal + (arg2 as u128) * (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u128);
        arg0.decimal_price = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4);
        let v5 = VolumeUpdateEvent{
            usd_volume_x2decimal : arg0.usd_volume_x2decimal,
            decimal_price        : arg0.decimal_price,
            decimal_coin         : arg0.decimal_coin,
        };
        0x2::event::emit<VolumeUpdateEvent>(v5);
    }

    public fun create(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : Volume {
        Volume{
            id                   : 0x2::object::new(arg1),
            usd_volume_x2decimal : 0,
            decimal_price        : 0,
            decimal_coin         : 0,
            pyth_price_id        : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

