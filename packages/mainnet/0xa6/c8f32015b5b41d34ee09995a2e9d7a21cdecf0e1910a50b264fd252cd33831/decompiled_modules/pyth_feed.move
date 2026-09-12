module 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed {
    struct RawSpot has copy, drop, store {
        pyth_source_id: u32,
        price_magnitude: u64,
        price_is_negative: bool,
        exponent_magnitude: u16,
        exponent_is_negative: bool,
        feed_update_timestamp_us: u64,
    }

    struct PythFeed has key {
        id: 0x2::object::UID,
        pyth_source_id: u32,
        propbook_underlying_id: 0x1::option::Option<u32>,
        version: u64,
        lane: 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleLane<RawSpot>,
    }

    public fun update(arg0: &mut PythFeed, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::update<RawSpot>(&mut arg0.lane, new_read(arg0, &arg1, 0x2::clock::timestamp_ms(arg2), arg3), arg0.propbook_underlying_id, id(arg0));
    }

    public fun insert_at(arg0: &mut PythFeed, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::insert_at<RawSpot>(&mut arg0.lane, new_insert_read(arg0, &arg1, 0x2::clock::timestamp_ms(arg2), arg3), arg0.propbook_underlying_id, id(arg0));
    }

    fun new_read(arg0: &PythFeed, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot> {
        new_raw_read(raw_spot_from_update(arg1, arg0.pyth_source_id), arg2, arg3)
    }

    public(friend) fun assign_underlying(arg0: &mut PythFeed, arg1: u32) {
        if (0x1::option::is_some<u32>(&arg0.propbook_underlying_id)) {
            assert!(*0x1::option::borrow<u32>(&arg0.propbook_underlying_id) == arg1, 8);
        } else {
            arg0.propbook_underlying_id = 0x1::option::some<u32>(arg1);
        };
    }

    public(friend) fun create_and_share(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = PythFeed{
            id                     : 0x2::object::new(arg1),
            pyth_source_id         : arg0,
            propbook_underlying_id : 0x1::option::none<u32>(),
            version                : 1,
            lane                   : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::new<RawSpot>(arg1),
        };
        0x2::transfer::share_object<PythFeed>(v0);
        id(&v0)
    }

    fun extract_lazer_exponent(arg0: 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16 {
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&arg0), 4);
        0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(arg0)
    }

    fun extract_lazer_feed_update_timestamp(arg0: 0x1::option::Option<0x1::option::Option<u64>>) : u64 {
        assert!(0x1::option::is_some<0x1::option::Option<u64>>(&arg0), 4);
        let v0 = 0x1::option::destroy_some<0x1::option::Option<u64>>(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 4);
        0x1::option::destroy_some<u64>(v0)
    }

    fun extract_lazer_price(arg0: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64 {
        assert!(0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&arg0), 4);
        let v0 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(arg0);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v0), 4);
        0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v0)
    }

    public fun id(arg0: &PythFeed) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun migrate(arg0: &mut PythFeed) {
        assert!(1 > arg0.version, 1);
        arg0.version = 1;
    }

    fun new_insert_read(arg0: &PythFeed, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot> {
        new_raw_insert_read(raw_spot_from_update(arg1, arg0.pyth_source_id), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg1), arg2, arg3)
    }

    fun new_raw_insert_read(arg0: RawSpot, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot> {
        assert!(arg1 % 1000 == 0, 5);
        assert!(arg1 - arg0.feed_update_timestamp_us <= 2000000, 7);
        0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::new_read<RawSpot>(arg1 / 1000, arg2, arg0, arg3)
    }

    fun new_raw_read(arg0: RawSpot, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot> {
        0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::new_read<RawSpot>(0x1::u64::div_ceil(arg0.feed_update_timestamp_us, 1000), arg1, arg0, arg2)
    }

    fun new_raw_spot(arg0: u32, arg1: u64, arg2: bool, arg3: u16, arg4: bool, arg5: u64) : RawSpot {
        RawSpot{
            pyth_source_id           : arg0,
            price_magnitude          : arg1,
            price_is_negative        : arg2,
            exponent_magnitude       : arg3,
            exponent_is_negative     : arg4,
            feed_update_timestamp_us : arg5,
        }
    }

    fun normalize_raw_spot(arg0: &RawSpot) : 0x1::option::Option<u64> {
        if (arg0.price_is_negative) {
            return 0x1::option::none<u64>()
        };
        let v0 = 9;
        let v1 = (arg0.exponent_magnitude as u64);
        let v2 = if (arg0.exponent_is_negative) {
            if (v1 <= v0) {
                let v3 = scale_up(arg0.price_magnitude, v0 - v1);
                if (0x1::option::is_none<u64>(&v3)) {
                    return 0x1::option::none<u64>()
                };
                0x1::option::destroy_some<u64>(v3)
            } else {
                let v4 = v1 - v0;
                if (v4 > 18) {
                    return 0x1::option::none<u64>()
                };
                arg0.price_magnitude / 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::pow10(v4)
            }
        } else {
            let v5 = scale_up(arg0.price_magnitude, v0 + v1);
            if (0x1::option::is_none<u64>(&v5)) {
                return 0x1::option::none<u64>()
            };
            0x1::option::destroy_some<u64>(v5)
        };
        if (v2 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(v2)
        }
    }

    public fun normalized_spot(arg0: &PythFeed) : 0x1::option::Option<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>> {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::latest_read<RawSpot>(&arg0.lane);
        if (0x1::option::is_none<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot>>(&v0)) {
            return 0x1::option::none<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>()
        };
        let v1 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot>>(v0);
        normalized_spot_from_read(&v1)
    }

    public fun normalized_spot_at(arg0: &PythFeed, arg1: u64) : 0x1::option::Option<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>> {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_at<RawSpot>(&arg0.lane, arg1);
        if (0x1::option::is_none<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot>>(&v0)) {
            return 0x1::option::none<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>()
        };
        let v1 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot>>(v0);
        normalized_spot_from_read(&v1)
    }

    fun normalized_spot_from_read(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot>) : 0x1::option::Option<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>> {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_value<RawSpot>(arg0);
        let v1 = normalize_raw_spot(&v0);
        if (0x1::option::is_none<u64>(&v1)) {
            0x1::option::none<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>()
        } else {
            0x1::option::some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::project_read<RawSpot, u64>(arg0, 0x1::option::destroy_some<u64>(v1)))
        }
    }

    public fun pyth_source_id(arg0: &PythFeed) : u32 {
        arg0.pyth_source_id
    }

    public fun raw_exponent_is_negative(arg0: &RawSpot) : bool {
        arg0.exponent_is_negative
    }

    public fun raw_exponent_magnitude(arg0: &RawSpot) : u16 {
        arg0.exponent_magnitude
    }

    public fun raw_feed_update_timestamp_us(arg0: &RawSpot) : u64 {
        arg0.feed_update_timestamp_us
    }

    public fun raw_price_is_negative(arg0: &RawSpot) : bool {
        arg0.price_is_negative
    }

    public fun raw_price_magnitude(arg0: &RawSpot) : u64 {
        arg0.price_magnitude
    }

    public fun raw_pyth_source_id(arg0: &RawSpot) : u32 {
        arg0.pyth_source_id
    }

    public fun raw_spot(arg0: &PythFeed) : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot> {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::latest_read<RawSpot>(&arg0.lane);
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot>>(&v0), 2);
        0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot>>(v0)
    }

    public fun raw_spot_at(arg0: &PythFeed, arg1: u64) : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot> {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_at<RawSpot>(&arg0.lane, arg1);
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot>>(&v0), 2);
        0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<RawSpot>>(v0)
    }

    fun raw_spot_from_update(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg1: u32) : RawSpot {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg0);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0)) {
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0, v1)) == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 4 */
                assert!(0x1::option::is_some<u64>(&v2), 3);
                let v3 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0, 0x1::option::destroy_some<u64>(v2));
                let v4 = extract_lazer_feed_update_timestamp(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v3));
                assert!(v4 <= 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg0), 6);
                let v5 = extract_lazer_price(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v3));
                let v6 = extract_lazer_exponent(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v3));
                let v7 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v5);
                let v8 = if (v7) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_negative(&v5)
                } else {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v5)
                };
                let v9 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v6);
                let v10 = if (v9) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v6)
                } else {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v6)
                };
                return new_raw_spot(arg1, v8, v7, v10, v9, v4)
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    fun scale_up(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        if (arg1 > 18) {
            return 0x1::option::none<u64>()
        };
        let v0 = (arg0 as u128) * (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::pow10(arg1) as u128);
        if (v0 > 18446744073709551615) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>((v0 as u64))
        }
    }

    public fun version(arg0: &PythFeed) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

