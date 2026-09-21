module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing {
    struct Pricer has copy, drop {
        expiry_market_id: 0x2::object::ID,
        forward: u64,
        svi: PricingSVI,
        pyth_spot_source_timestamp_ms: u64,
        block_scholes_spot_source_timestamp_ms: u64,
        block_scholes_forward_source_timestamp_ms: u64,
        block_scholes_svi_source_timestamp_ms: u64,
    }

    struct RangePrice has copy, drop {
        lower_up: 0x1::option::Option<u64>,
        higher_up: 0x1::option::Option<u64>,
    }

    struct FrozenPricer has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        forward: u64,
        svi: PricingSVI,
        pyth_spot_source_timestamp_ms: u64,
        block_scholes_spot_source_timestamp_ms: u64,
        block_scholes_forward_source_timestamp_ms: u64,
        block_scholes_svi_source_timestamp_ms: u64,
    }

    struct RawSVI has copy, drop {
        a: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64,
        b: u64,
        rho: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64,
        m: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64,
        sigma: u64,
    }

    struct PricingSVI has copy, drop, store {
        a_magnitude: u128,
        a_is_negative: bool,
        b: u128,
        rho: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64,
        m: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64,
        sigma: u64,
    }

    fun a(arg0: &RawSVI) : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64 {
        arg0.a
    }

    fun assert_current_oracles(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg1: u32, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore) {
        assert_current_pyth(arg0, arg1, arg2);
        let v0 = current_block_scholes_binding(arg0, arg1);
        assert!(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::block_scholes_value_store_id(&v0) == 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::value_store_id(arg3), 8);
        assert!(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::block_scholes_svi_store_id(&v0) == 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_store_id(arg4), 11);
    }

    fun assert_current_pyth(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg1: u32, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed) {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::propbook_pyth_id_for_underlying(arg0, arg1);
        let v1 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::id(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&v0, &v1), 7);
    }

    fun assert_inputs_pricing_safe(arg0: u64, arg1: u64, arg2: &RawSVI) {
        assert!(arg0 > 0 && arg1 > 0, 5);
        assert!(arg1 <= 184467440737095516, 5);
        assert!(0x1::u64::div_ceil(arg1, 100) <= arg0, 5);
        let v0 = a(arg2);
        assert!(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v0) <= 100000000000, 5);
        assert!(b(arg2) <= 100000000000, 5);
        let v1 = rho(arg2);
        assert!(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v1) <= 1000000000, 5);
        let v2 = m(arg2);
        assert!(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v2) <= 100000000000, 5);
        assert!(sigma(arg2) >= 1000000 && sigma(arg2) <= 100000000000, 5);
        assert_min_total_variance_positive(arg2);
    }

    fun assert_min_total_variance_positive(arg0: &RawSVI) {
        let v0 = a(arg0);
        let v1 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_u64(min_svi_variance_increment(arg0));
        let v2 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::add(&v1, &v0);
        assert!(is_positive(&v2), 14);
    }

    fun assert_oracle_not_written_this_tx(arg0: &vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0 != 0x2::tx_context::digest(arg1), 15);
    }

    fun b(arg0: &RawSVI) : u64 {
        arg0.b
    }

    public(friend) fun block_scholes_forward_source_timestamp_ms(arg0: &Pricer) : u64 {
        arg0.block_scholes_forward_source_timestamp_ms
    }

    public(friend) fun block_scholes_spot_source_timestamp_ms(arg0: &Pricer) : u64 {
        arg0.block_scholes_spot_source_timestamp_ms
    }

    public(friend) fun block_scholes_svi_source_timestamp_ms(arg0: &Pricer) : u64 {
        arg0.block_scholes_svi_source_timestamp_ms
    }

    fun compute_nd2(arg0: &PricingSVI, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0, 0);
        let v0 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::ln(arg2);
        let v1 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::ln(arg1);
        let v2 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::sub(&v0, &v1);
        let v3 = arg0.m;
        let v4 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::sub(&v2, &v3);
        let v5 = arg0.sigma;
        let v6 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_u64(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::sqrt_down(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::square_scaled(&v4) + 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v5, v5)));
        let v7 = arg0.rho;
        let v8 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::mul_scaled(&v7, &v4);
        let v9 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::add(&v8, &v6);
        assert!(!0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&v9), 1);
        let v10 = arg0.b;
        let (v11, v12) = variance_sqrt_and_d2(arg0.a_magnitude, arg0.a_is_negative, v10, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v9), &v2);
        let v13 = v12;
        let v14 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::div_scaled(&v4, &v6);
        let v15 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::add(&v7, &v14);
        let v16 = 1000000000;
        let v17 = ((v10 * (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v15) as u128) / v16 * v16) as u64);
        if (v17 == 0) {
            return 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::normal_cdf(&v13)
        };
        let v18 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_down(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::normal_pdf(&v13), v17, 2 * v11), 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&v15));
        let v19 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_u64(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::normal_cdf(&v13));
        let v20 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::sub(&v19, &v18);
        if (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&v20)) {
            return 0
        };
        if (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v20) > 1000000000) {
            return 1000000000
        };
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v20)
    }

    fun compute_up_price(arg0: &PricingSVI, arg1: u64, arg2: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike) : u64 {
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_neg_inf(arg2)) {
            return 1000000000
        };
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_pos_inf(arg2)) {
            return 0
        };
        compute_nd2(arg0, arg1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::value(arg2))
    }

    fun current_block_scholes_binding(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg1: u32) : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::BlockScholesStorePair {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::propbook_block_scholes_store_pair_for_underlying(arg0, arg1);
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::BlockScholesStorePair>(&v0), 8);
        0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::BlockScholesStorePair>(v0)
    }

    public(friend) fun expiry_market_id(arg0: &Pricer) : 0x2::object::ID {
        arg0.expiry_market_id
    }

    public fun higher_up(arg0: &RangePrice) : 0x1::option::Option<u64> {
        arg0.higher_up
    }

    public(friend) fun into_frozen(arg0: Pricer) : FrozenPricer {
        let Pricer {
            expiry_market_id                          : v0,
            forward                                   : v1,
            svi                                       : v2,
            pyth_spot_source_timestamp_ms             : v3,
            block_scholes_spot_source_timestamp_ms    : v4,
            block_scholes_forward_source_timestamp_ms : v5,
            block_scholes_svi_source_timestamp_ms     : v6,
        } = arg0;
        FrozenPricer{
            expiry_market_id                          : v0,
            forward                                   : v1,
            svi                                       : v2,
            pyth_spot_source_timestamp_ms             : v3,
            block_scholes_spot_source_timestamp_ms    : v4,
            block_scholes_forward_source_timestamp_ms : v5,
            block_scholes_svi_source_timestamp_ms     : v6,
        }
    }

    fun is_positive(arg0: &0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64) : bool {
        !0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(arg0) && !0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_zero(arg0)
    }

    public(friend) fun load_exact_block_scholes_spot(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg2: u32, arg3: u64) : 0x1::option::Option<u64> {
        let v0 = current_block_scholes_binding(arg0, arg2);
        assert!(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::block_scholes_value_store_id(&v0) == 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::value_store_id(arg1), 8);
        let v1 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::spot_at(arg1, arg3);
        if (0x1::option::is_none<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<u128>>(&v1)) {
            return 0x1::option::none<u64>()
        };
        let v2 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<u128>>(v1);
        let v3 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_value<u128>(&v2);
        if (v3 == 0 || v3 > 18446744073709551615) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((v3 as u64))
    }

    public(friend) fun load_exact_spot(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg2: u32, arg3: u64) : 0x1::option::Option<u64> {
        assert_current_pyth(arg0, arg2, arg1);
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::normalized_spot_at(arg1, arg3);
        if (0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v0)) {
            let v2 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(v0);
            0x1::option::some<u64>(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_value<u64>(&v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun load_live_pricer(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg5: 0x2::object::ID, arg6: u32, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : Pricer {
        assert_current_oracles(arg1, arg6, arg2, arg3, arg4);
        assert!(0x2::clock::timestamp_ms(arg8) < arg7, 9);
        resolve_live_pricer(arg0, arg2, arg3, arg4, arg5, arg7, arg8, arg9)
    }

    public fun lower_up(arg0: &RangePrice) : 0x1::option::Option<u64> {
        arg0.lower_up
    }

    fun m(arg0: &RawSVI) : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64 {
        arg0.m
    }

    fun min_svi_variance_increment(arg0: &RawSVI) : u64 {
        let v0 = rho(arg0);
        let v1 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v0);
        if (v1 == 1000000000) {
            return 0
        };
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(b(arg0), 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(sigma(arg0), 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::sqrt_down(1000000000 - 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v1, v1))))
    }

    fun narrow_input(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 16);
        (arg0 as u64)
    }

    fun narrow_price(arg0: u128) : u64 {
        narrow_input(arg0)
    }

    fun narrow_svi(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams) : RawSVI {
        RawSVI{
            a     : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts(narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_a_magnitude(arg0)), 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_a_is_negative(arg0)),
            b     : narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_b(arg0)),
            rho   : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts(narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_rho_magnitude(arg0)), 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_rho_is_negative(arg0)),
            m     : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts(narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_m_magnitude(arg0)), 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_m_is_negative(arg0)),
            sigma : narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_sigma(arg0)),
        }
    }

    public fun probability(arg0: &RangePrice) : u64 {
        0x1::u64::saturating_sub(0x1::option::get_with_default<u64>(&arg0.lower_up, 1000000000), 0x1::option::get_with_default<u64>(&arg0.higher_up, 0))
    }

    public(friend) fun pyth_spot_source_timestamp_ms(arg0: &Pricer) : u64 {
        arg0.pyth_spot_source_timestamp_ms
    }

    public fun range_price(arg0: &Pricer, arg1: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike, arg2: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike) : RangePrice {
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::value(arg1) < 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::value(arg2), 3);
        let v0 = if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_neg_inf(arg1)) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(up_price(arg0, arg1))
        };
        let v1 = if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_pos_inf(arg2)) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(up_price(arg0, arg2))
        };
        RangePrice{
            lower_up  : v0,
            higher_up : v1,
        }
    }

    fun resolve_live_pricer(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : Pricer {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::forward(arg2, arg5);
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<u128>>(&v0), 12);
        let v1 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<u128>>(v0);
        let v2 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_writer_digest<u128>(&v1);
        assert_oracle_not_written_this_tx(&v2, arg7);
        let v3 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::recent_spot_at(arg2, 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_source_timestamp_ms<u128>(&v1));
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<u128>>(&v3), 12);
        let v4 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<u128>>(v3);
        let v5 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_writer_digest<u128>(&v4);
        assert_oracle_not_written_this_tx(&v5, arg7);
        let v6 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_source_timestamp_ms<u128>(&v4);
        assert!(timestamp_is_fresh(v6, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::block_scholes_price_freshness_ms(arg0), arg6), 4);
        let v7 = narrow_price(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_value<u128>(&v4));
        let v8 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_source_timestamp_ms<u128>(&v1);
        assert!(timestamp_is_fresh(v8, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::block_scholes_price_freshness_ms(arg0), arg6), 4);
        let v9 = narrow_price(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_value<u128>(&v1));
        let v10 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi(arg3, arg5);
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>>(&v10), 13);
        let v11 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>>(v10);
        let v12 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_writer_digest<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>(&v11);
        assert_oracle_not_written_this_tx(&v12, arg7);
        let v13 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_source_timestamp_ms<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>(&v11);
        assert!(timestamp_is_fresh(v13, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::block_scholes_svi_freshness_ms(arg0), arg6), 10);
        let v14 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_value<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>(&v11);
        let v15 = narrow_svi(&v14);
        assert_inputs_pricing_safe(v7, v9, &v15);
        let v16 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::normalized_spot(arg1);
        let v17 = if (0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v16)) {
            0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_source_timestamp_ms<u64>(0x1::option::borrow<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v16))
        } else {
            0
        };
        let v18 = v9;
        let v19 = if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::use_pyth_spot_for_forward(arg0)) {
            if (0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v16)) {
                timestamp_is_fresh(v17, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::pyth_spot_freshness_ms(arg0), arg6)
            } else {
                false
            }
        } else {
            false
        };
        if (v19) {
            let v20 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(v16);
            let v21 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_writer_digest<u64>(&v20);
            assert_oracle_not_written_this_tx(&v21, arg7);
            let v22 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_value<u64>(&v20);
            assert!(v22 <= 184467440737095516, 6);
            v18 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_down(v22, v9, v7);
        };
        Pricer{
            expiry_market_id                          : arg4,
            forward                                   : v18,
            svi                                       : roll_down_svi(&v15, v13, arg5, arg6),
            pyth_spot_source_timestamp_ms             : v17,
            block_scholes_spot_source_timestamp_ms    : v6,
            block_scholes_forward_source_timestamp_ms : v8,
            block_scholes_svi_source_timestamp_ms     : v13,
        }
    }

    fun rho(arg0: &RawSVI) : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64 {
        arg0.rho
    }

    fun roll_down_svi(arg0: &RawSVI, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : PricingSVI {
        let v0 = arg2 - 0x2::clock::timestamp_ms(arg3);
        let v1 = arg2 - arg1;
        let v2 = a(arg0);
        PricingSVI{
            a_magnitude   : roll_down_to_1e18(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v2), v0, v1),
            a_is_negative : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&v2),
            b             : roll_down_to_1e18(b(arg0), v0, v1),
            rho           : rho(arg0),
            m             : m(arg0),
            sigma         : sigma(arg0),
        }
    }

    public(friend) fun roll_down_to_1e18(arg0: u64, arg1: u64, arg2: u64) : u128 {
        (((arg0 as u256) * 1000000000 * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    fun sigma(arg0: &RawSVI) : u64 {
        arg0.sigma
    }

    public(friend) fun thaw(arg0: &FrozenPricer) : Pricer {
        Pricer{
            expiry_market_id                          : arg0.expiry_market_id,
            forward                                   : arg0.forward,
            svi                                       : arg0.svi,
            pyth_spot_source_timestamp_ms             : arg0.pyth_spot_source_timestamp_ms,
            block_scholes_spot_source_timestamp_ms    : arg0.block_scholes_spot_source_timestamp_ms,
            block_scholes_forward_source_timestamp_ms : arg0.block_scholes_forward_source_timestamp_ms,
            block_scholes_svi_source_timestamp_ms     : arg0.block_scholes_svi_source_timestamp_ms,
        }
    }

    fun timestamp_is_fresh(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0 > 0) {
            if (arg0 <= v0) {
                v0 - arg0 <= arg1
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun up_price(arg0: &Pricer, arg1: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike) : u64 {
        compute_up_price(&arg0.svi, arg0.forward, arg1)
    }

    fun variance_sqrt_and_d2(arg0: u128, arg1: bool, arg2: u128, arg3: u64, arg4: &0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64) : (u64, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64) {
        let v0 = 1000000000;
        let v1 = arg2 * (arg3 as u128) / v0;
        let v2 = if (arg1) {
            assert!(v1 > arg0, 2);
            v1 - arg0
        } else {
            assert!(v1 + arg0 > 0, 2);
            v1 + arg0
        };
        let v3 = (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::sqrt_u128_down(v2) as u64);
        let v4 = (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(arg4) as u128) * v0;
        let v5 = v2 / 2;
        let (v6, v7) = if (!0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(arg4)) {
            (v4 + v5, false)
        } else if (v5 >= v4) {
            (v5 - v4, false)
        } else {
            (v4 - v5, true)
        };
        let v8 = 8 * v0 + 1;
        let v9 = v6 / (v3 as u128);
        let v10 = if (v9 > v8) {
            v8
        } else {
            v9
        };
        (v3, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts((v10 as u64), !v7))
    }

    // decompiled from Move bytecode v7
}

