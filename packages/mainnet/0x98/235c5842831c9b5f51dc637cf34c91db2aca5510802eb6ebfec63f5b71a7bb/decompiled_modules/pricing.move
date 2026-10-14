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

    struct VolSnapshot has copy, drop, store {
        pyth_source_id: u32,
        bs_spot: u64,
        bs_forward: u64,
        svi_a: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64,
        svi_b: u64,
        svi_rho: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64,
        svi_m: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64,
        svi_sigma: u64,
        bs_spot_source_timestamp_ms: u64,
        bs_forward_source_timestamp_ms: u64,
        svi_source_timestamp_ms: u64,
    }

    fun a(arg0: &RawSVI) : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64 {
        arg0.a
    }

    fun b(arg0: &RawSVI) : u64 {
        arg0.b
    }

    fun bs_binding(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg1: u32) : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::BlockScholesStorePair {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::propbook_block_scholes_store_pair_for_underlying(arg0, arg1);
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::BlockScholesStorePair>(&v0), 8);
        0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::BlockScholesStorePair>(v0)
    }

    public(friend) fun bs_fwd_ts(arg0: &Pricer) : u64 {
        arg0.block_scholes_forward_source_timestamp_ms
    }

    public(friend) fun bs_spot_at(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg2: u32, arg3: u64) : 0x1::option::Option<u64> {
        let v0 = bs_binding(arg0, arg2);
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

    public(friend) fun bs_spot_ts(arg0: &Pricer) : u64 {
        arg0.block_scholes_spot_source_timestamp_ms
    }

    public(friend) fun bs_svi_ts(arg0: &Pricer) : u64 {
        arg0.block_scholes_svi_source_timestamp_ms
    }

    fun chk_inputs(arg0: u64, arg1: u64, arg2: &RawSVI) {
        assert!(0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::inputs_ok(arg0, arg1, b(arg2), rho(arg2), m(arg2), sigma(arg2)), 5);
        assert!(0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::raw_var_ok(a(arg2), b(arg2), rho(arg2), sigma(arg2)), 14);
    }

    fun chk_not_tx(arg0: &vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0 != 0x2::tx_context::digest(arg1), 15);
    }

    fun chk_oracles(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg1: u32, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore) {
        chk_pyth(arg0, arg1, arg2);
        let v0 = bs_binding(arg0, arg1);
        assert!(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::block_scholes_value_store_id(&v0) == 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::value_store_id(arg3), 8);
        assert!(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::block_scholes_svi_store_id(&v0) == 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_store_id(arg4), 11);
    }

    fun chk_pyth(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg1: u32, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed) {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::propbook_pyth_id_for_underlying(arg0, arg1);
        let v1 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::id(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&v0, &v1), 7);
    }

    fun eval_range(arg0: &Pricer, arg1: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike, arg2: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike) : (0x1::option::Option<RangePrice>, u64) {
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::value(arg1) >= 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::value(arg2)) {
            return (0x1::option::none<RangePrice>(), 3)
        };
        let v0 = 0x1::option::none<u64>();
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_neg_inf(arg1)) {
            let (v1, v2) = eval_up(&arg0.svi, arg0.forward, arg1);
            let v3 = v1;
            if (0x1::option::is_none<u64>(&v3)) {
                return (0x1::option::none<RangePrice>(), v2)
            };
            v0 = v3;
        };
        let v4 = 0x1::option::none<u64>();
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_pos_inf(arg2)) {
            let (v5, v6) = eval_up(&arg0.svi, arg0.forward, arg2);
            let v7 = v5;
            if (0x1::option::is_none<u64>(&v7)) {
                return (0x1::option::none<RangePrice>(), v6)
            };
            v4 = v7;
        };
        let v8 = RangePrice{
            lower_up  : v0,
            higher_up : v4,
        };
        (0x1::option::some<RangePrice>(v8), 0)
    }

    fun eval_up(arg0: &PricingSVI, arg1: u64, arg2: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike) : (0x1::option::Option<u64>, u64) {
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_neg_inf(arg2)) {
            return (0x1::option::some<u64>(1000000000), 0)
        };
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_pos_inf(arg2)) {
            return (0x1::option::some<u64>(0), 0)
        };
        0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::digital(arg0.a_magnitude, arg0.a_is_negative, arg0.b, arg0.rho, arg0.m, arg0.sigma, arg1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::value(arg2))
    }

    public(friend) fun exact_spot(arg0: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg2: u32, arg3: u64) : 0x1::option::Option<u64> {
        chk_pyth(arg0, arg2, arg1);
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::normalized_spot_at(arg1, arg3);
        if (0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v0)) {
            let v2 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(v0);
            0x1::option::some<u64>(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_value<u64>(&v2))
        } else {
            0x1::option::none<u64>()
        }
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

    fun is_fresh(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
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

    public(friend) fun load_live_pricer(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg5: 0x2::object::ID, arg6: u32, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : Pricer {
        chk_oracles(arg1, arg6, arg2, arg3, arg4);
        assert!(0x2::clock::timestamp_ms(arg8) < arg7, 9);
        let (_, v1) = resolve_live(arg0, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
        v1
    }

    public(friend) fun load_vol(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg5: 0x2::object::ID, arg6: u32, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : (VolSnapshot, Pricer) {
        chk_oracles(arg1, arg6, arg2, arg3, arg4);
        assert!(0x2::clock::timestamp_ms(arg9) < arg7, 9);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::pyth_forward(arg0), 19);
        let (v0, v1) = resolve_live(arg0, arg2, arg3, arg4, arg5, arg7, arg9, arg10);
        let v2 = v0;
        assert!(is_fresh(v2.svi_source_timestamp_ms, arg8, arg9), 10);
        (v2, v1)
    }

    public fun lower_up(arg0: &RangePrice) : 0x1::option::Option<u64> {
        arg0.lower_up
    }

    fun m(arg0: &RawSVI) : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64 {
        arg0.m
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

    public(friend) fun pricer_at(arg0: &VolSnapshot, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: u64) : 0x1::option::Option<Pricer> {
        if (arg3 >= arg5) {
            return 0x1::option::none<Pricer>()
        };
        let v0 = 0x1::option::destroy_with_default<u64>(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::try_mul_div_down(arg1, arg0.bs_forward, arg0.bs_spot), 0);
        if (v0 == 0) {
            return 0x1::option::none<Pricer>()
        };
        let v1 = pricer_of(arg0, arg4, arg5, v0, arg2, arg3);
        let v2 = &v1.svi;
        if (!0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::var_positive(v2.a_magnitude, v2.a_is_negative, v2.b, v2.rho, v2.sigma)) {
            return 0x1::option::none<Pricer>()
        };
        0x1::option::some<Pricer>(v1)
    }

    fun pricer_of(arg0: &VolSnapshot, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : Pricer {
        Pricer{
            expiry_market_id                          : arg1,
            forward                                   : arg3,
            svi                                       : roll_svi(arg0, arg2, arg5),
            pyth_spot_source_timestamp_ms             : arg4,
            block_scholes_spot_source_timestamp_ms    : arg0.bs_spot_source_timestamp_ms,
            block_scholes_forward_source_timestamp_ms : arg0.bs_forward_source_timestamp_ms,
            block_scholes_svi_source_timestamp_ms     : arg0.svi_source_timestamp_ms,
        }
    }

    public fun probability(arg0: &RangePrice) : u64 {
        0x1::u64::saturating_sub(0x1::option::get_with_default<u64>(&arg0.lower_up, 1000000000), 0x1::option::get_with_default<u64>(&arg0.higher_up, 0))
    }

    public(friend) fun pyth_source_id(arg0: &VolSnapshot) : u32 {
        arg0.pyth_source_id
    }

    public(friend) fun pyth_ts(arg0: &Pricer) : u64 {
        arg0.pyth_spot_source_timestamp_ms
    }

    public fun range_price(arg0: &Pricer, arg1: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike, arg2: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike) : RangePrice {
        let (v0, v1) = eval_range(arg0, arg1, arg2);
        let v2 = v0;
        assert!(0x1::option::is_some<RangePrice>(&v2), v1);
        0x1::option::destroy_some<RangePrice>(v2)
    }

    fun read_inputs(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : VolSnapshot {
        let v0 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::forward(arg2, arg4);
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<u128>>(&v0), 12);
        let v1 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<u128>>(v0);
        let v2 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_writer_digest<u128>(&v1);
        chk_not_tx(&v2, arg6);
        let v3 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::recent_spot_at(arg2, 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_source_timestamp_ms<u128>(&v1));
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<u128>>(&v3), 12);
        let v4 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<u128>>(v3);
        let v5 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_writer_digest<u128>(&v4);
        chk_not_tx(&v5, arg6);
        let v6 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_source_timestamp_ms<u128>(&v4);
        assert!(is_fresh(v6, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::bs_age_ms(arg0), arg5), 4);
        let v7 = narrow_price(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_value<u128>(&v4));
        let v8 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_source_timestamp_ms<u128>(&v1);
        assert!(is_fresh(v8, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::bs_age_ms(arg0), arg5), 4);
        let v9 = narrow_price(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_value<u128>(&v1));
        let v10 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi(arg3, arg4);
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>>(&v10), 13);
        let v11 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>>(v10);
        let v12 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_writer_digest<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>(&v11);
        chk_not_tx(&v12, arg6);
        let v13 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_source_timestamp_ms<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>(&v11);
        assert!(is_fresh(v13, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::svi_age_ms(arg0), arg5), 10);
        let v14 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_value<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>(&v11);
        let v15 = narrow_svi(&v14);
        chk_inputs(v7, v9, &v15);
        VolSnapshot{
            pyth_source_id                 : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::pyth_source_id(arg1),
            bs_spot                        : v7,
            bs_forward                     : v9,
            svi_a                          : v15.a,
            svi_b                          : v15.b,
            svi_rho                        : v15.rho,
            svi_m                          : v15.m,
            svi_sigma                      : v15.sigma,
            bs_spot_source_timestamp_ms    : v6,
            bs_forward_source_timestamp_ms : v8,
            svi_source_timestamp_ms        : v13,
        }
    }

    fun resolve_live(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (VolSnapshot, Pricer) {
        let v0 = read_inputs(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        let v1 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::normalized_spot(arg1);
        let v2 = if (0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v1)) {
            0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_source_timestamp_ms<u64>(0x1::option::borrow<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v1))
        } else {
            0
        };
        let v3 = v0.bs_forward;
        let v4 = if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::pyth_forward(arg0)) {
            if (0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v1)) {
                is_fresh(v2, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::pyth_age_ms(arg0), arg6)
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            let v5 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(v1);
            let v6 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_writer_digest<u64>(&v5);
            chk_not_tx(&v6, arg7);
            let v7 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_value<u64>(&v5);
            assert!(v7 <= 184467440737095516, 6);
            v3 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_down(v7, v0.bs_forward, v0.bs_spot);
        };
        (v0, pricer_of(&v0, arg4, arg5, v3, v2, 0x2::clock::timestamp_ms(arg6)))
    }

    fun rho(arg0: &RawSVI) : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64 {
        arg0.rho
    }

    fun roll_svi(arg0: &VolSnapshot, arg1: u64, arg2: u64) : PricingSVI {
        let v0 = arg1 - arg2;
        let v1 = arg1 - arg0.svi_source_timestamp_ms;
        let v2 = arg0.svi_a;
        PricingSVI{
            a_magnitude   : 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::roll_down(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v2), v0, v1),
            a_is_negative : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&v2),
            b             : 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::roll_down(arg0.svi_b, v0, v1),
            rho           : arg0.svi_rho,
            m             : arg0.svi_m,
            sigma         : arg0.svi_sigma,
        }
    }

    public(friend) fun safe_spot(arg0: u64) : bool {
        arg0 > 0 && arg0 <= 184467440737095516
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

    public(friend) fun try_range(arg0: &Pricer, arg1: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike, arg2: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike) : 0x1::option::Option<RangePrice> {
        let (v0, _) = eval_range(arg0, arg1, arg2);
        v0
    }

    public fun up_price(arg0: &Pricer, arg1: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::Strike) : u64 {
        let (v0, v1) = eval_up(&arg0.svi, arg0.forward, arg1);
        let v2 = v0;
        assert!(0x1::option::is_some<u64>(&v2), v1);
        0x1::option::destroy_some<u64>(v2)
    }

    // decompiled from Move bytecode v7
}

