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

    struct SviKey has copy, drop, store {
        dummy_field: bool,
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

    fun chk_inputs(arg0: &VolSnapshot, arg1: &PricingSVI, arg2: &PricingSVI, arg3: bool) {
        assert!(0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::inputs_ok(arg0.bs_spot, arg0.bs_forward, arg0.svi_b, arg0.svi_rho, arg0.svi_m, arg0.svi_sigma), 5);
        assert!(arg3 && var_ok(arg1) && var_ok(arg2) || 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::raw_var_ok(arg0.svi_a, arg0.svi_b, arg0.svi_rho, arg0.svi_sigma), 14);
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
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_ninf(arg1)) {
            let (v1, v2) = eval_up(&arg0.svi, arg0.forward, arg1);
            let v3 = v1;
            if (0x1::option::is_none<u64>(&v3)) {
                return (0x1::option::none<RangePrice>(), v2)
            };
            v0 = v3;
        };
        let v4 = 0x1::option::none<u64>();
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_pinf(arg2)) {
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
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_ninf(arg2)) {
            return (0x1::option::some<u64>(1000000000), 0)
        };
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::is_pinf(arg2)) {
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

    fun keep_svi(arg0: &mut 0x2::object::UID, arg1: &VolSnapshot, arg2: PricingSVI) {
        let v0 = SviKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SviKey>(arg0, v0)) {
            let v1 = SviKey{dummy_field: false};
            0x2::dynamic_field::add<SviKey, 0x2::vec_map::VecMap<u64, PricingSVI>>(arg0, v1, 0x2::vec_map::empty<u64, PricingSVI>());
        };
        let v2 = SviKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<SviKey, 0x2::vec_map::VecMap<u64, PricingSVI>>(arg0, v2);
        let v4 = arg1.svi_source_timestamp_ms;
        let v5 = 0x2::vec_map::try_get<u64, PricingSVI>(v3, &v4);
        if (0x1::option::is_some<PricingSVI>(&v5)) {
            if (0x1::option::destroy_some<PricingSVI>(v5) != arg2) {
                0x2::vec_map::get_mut<u64, PricingSVI>(v3, &v4).sigma = 0;
            };
            return
        };
        0x2::vec_map::insert<u64, PricingSVI>(v3, v4, arg2);
        if (0x2::vec_map::length<u64, PricingSVI>(v3) > 64) {
            let (_, _) = 0x2::vec_map::remove_entry_by_idx<u64, PricingSVI>(v3, 0);
        };
    }

    public(friend) fun load_live_pricer(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg5: 0x2::object::ID, arg6: u32, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : Pricer {
        chk_oracles(arg1, arg6, arg2, arg3, arg4);
        assert!(0x2::clock::timestamp_ms(arg8) < arg7, 9);
        let (_, v1, _, _) = resolve_live(arg0, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
        v1
    }

    public(friend) fun load_vol(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg5: 0x2::object::ID, arg6: u32, arg7: u64, arg8: u64, arg9: &mut 0x2::object::UID, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : (VolSnapshot, Pricer) {
        chk_oracles(arg1, arg6, arg2, arg3, arg4);
        assert!(0x2::clock::timestamp_ms(arg10) < arg7, 9);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::pyth_fwd(arg0), 19);
        let (v0, v1, v2, v3) = resolve_live(arg0, arg2, arg3, arg4, arg5, arg7, arg10, arg11);
        let v4 = v0;
        assert!(is_fresh(v4.svi_source_timestamp_ms, arg8, arg10), 10);
        if (v3) {
            keep_svi(arg9, &v4, v2);
        };
        (v4, v1)
    }

    public fun lower_up(arg0: &RangePrice) : 0x1::option::Option<u64> {
        arg0.lower_up
    }

    fun narrow_input(arg0: u128, arg1: bool) : u64 {
        let v0 = if (arg1) {
            1000000000
        } else {
            1
        };
        let v1 = if (arg0 % v0 > (v0 - 1) / 2) {
            1
        } else {
            0
        };
        let v2 = arg0 / v0 + v1;
        assert!(v2 <= 18446744073709551615, 16);
        (v2 as u64)
    }

    fun own_svi(arg0: &VolSnapshot) : PricingSVI {
        let v0 = 1000000000;
        PricingSVI{
            a_magnitude   : (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&arg0.svi_a) as u128) * v0,
            a_is_negative : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&arg0.svi_a),
            b             : (arg0.svi_b as u128) * v0,
            rho           : arg0.svi_rho,
            m             : arg0.svi_m,
            sigma         : arg0.svi_sigma,
        }
    }

    public(friend) fun pricer_at(arg0: &VolSnapshot, arg1: &0x2::object::UID, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::object::ID, arg6: u64) : 0x1::option::Option<Pricer> {
        if (arg4 >= arg6) {
            return 0x1::option::none<Pricer>()
        };
        let v0 = 0x1::option::destroy_with_default<u64>(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::try_mul_div_down(arg2, arg0.bs_forward, arg0.bs_spot), 0);
        if (v0 == 0) {
            return 0x1::option::none<Pricer>()
        };
        let v1 = svi_for(arg1, arg0);
        let v2 = pricer_of(arg0, &v1, arg5, arg6, v0, arg3, arg4);
        if (!var_ok(&v2.svi)) {
            return 0x1::option::none<Pricer>()
        };
        0x1::option::some<Pricer>(v2)
    }

    fun pricer_of(arg0: &VolSnapshot, arg1: &PricingSVI, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : Pricer {
        Pricer{
            expiry_market_id                          : arg2,
            forward                                   : arg4,
            svi                                       : roll_svi(arg1, arg3, arg6, arg0.svi_source_timestamp_ms),
            pyth_spot_source_timestamp_ms             : arg5,
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

    fun read_inputs(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (VolSnapshot, PricingSVI, bool) {
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
        assert!(is_fresh(v6, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::bs_age(arg0), arg5), 4);
        let v7 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_source_timestamp_ms<u128>(&v1);
        assert!(is_fresh(v7, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::bs_age(arg0), arg5), 4);
        let v8 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi(arg3, arg4);
        assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>>(&v8), 13);
        let v9 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BsRead<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>>(v8);
        let v10 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_writer_digest<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>(&v9);
        chk_not_tx(&v10, arg6);
        let v11 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_source_timestamp_ms<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>(&v9);
        assert!(is_fresh(v11, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::svi_age(arg0), arg5), 10);
        let v12 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_decimals(arg3);
        assert!(v12 == 9 || v12 == 18, 5);
        let v13 = v12 != 9;
        let v14 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_value<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::SVIParams>(&v9);
        let v15 = VolSnapshot{
            pyth_source_id                 : 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::pyth_source_id(arg1),
            bs_spot                        : narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_value<u128>(&v4), false),
            bs_forward                     : narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::read_value<u128>(&v1), false),
            svi_a                          : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts(narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_a_magnitude(&v14), v13), 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_a_is_negative(&v14)),
            svi_b                          : narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_b(&v14), v13),
            svi_rho                        : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts(narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_rho_magnitude(&v14), v13), 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_rho_is_negative(&v14)),
            svi_m                          : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts(narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_m_magnitude(&v14), v13), 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_m_is_negative(&v14)),
            svi_sigma                      : narrow_input(0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_sigma(&v14), v13),
            bs_spot_source_timestamp_ms    : v6,
            bs_forward_source_timestamp_ms : v7,
            svi_source_timestamp_ms        : v11,
        };
        let v16 = own_svi(&v15);
        if (v13) {
            v16.a_magnitude = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_a_magnitude(&v14);
            v16.a_is_negative = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_a_is_negative(&v14);
            v16.b = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::svi_b(&v14);
        };
        chk_inputs(&v15, &v16, &v16, v13);
        (v15, v16, v13)
    }

    fun resolve_live(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (VolSnapshot, Pricer, PricingSVI, bool) {
        let (v0, v1, v2) = read_inputs(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        let v3 = v1;
        let v4 = v0;
        let v5 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::normalized_spot(arg1);
        let v6 = if (0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v5)) {
            0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_source_timestamp_ms<u64>(0x1::option::borrow<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v5))
        } else {
            0
        };
        let v7 = v4.bs_forward;
        let v8 = if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::pyth_fwd(arg0)) {
            if (0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(&v5)) {
                is_fresh(v6, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::pyth_age(arg0), arg6)
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            let v9 = 0x1::option::destroy_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::OracleRead<u64>>(v5);
            let v10 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_writer_digest<u64>(&v9);
            chk_not_tx(&v10, arg7);
            let v11 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane::read_value<u64>(&v9);
            assert!(v11 <= 184467440737095516, 6);
            v7 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_down(v11, v4.bs_forward, v4.bs_spot);
        };
        (v4, pricer_of(&v4, &v3, arg4, arg5, v7, v6, 0x2::clock::timestamp_ms(arg6)), v3, v2)
    }

    fun roll_svi(arg0: &PricingSVI, arg1: u64, arg2: u64, arg3: u64) : PricingSVI {
        let v0 = ((arg1 - arg2) as u256);
        let v1 = ((arg1 - arg3) as u256);
        let v2 = *arg0;
        v2.a_magnitude = (((arg0.a_magnitude as u256) * v0 / v1) as u128);
        v2.b = (((arg0.b as u256) * v0 / v1) as u128);
        v2
    }

    public(friend) fun safe_spot(arg0: u64) : bool {
        arg0 > 0 && arg0 <= 184467440737095516
    }

    fun svi_for(arg0: &0x2::object::UID, arg1: &VolSnapshot) : PricingSVI {
        let v0 = own_svi(arg1);
        let v1 = SviKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SviKey>(arg0, v1)) {
            return v0
        };
        let v2 = SviKey{dummy_field: false};
        let v3 = 0x2::vec_map::try_get<u64, PricingSVI>(0x2::dynamic_field::borrow<SviKey, 0x2::vec_map::VecMap<u64, PricingSVI>>(arg0, v2), &arg1.svi_source_timestamp_ms);
        if (0x1::option::is_some<PricingSVI>(&v3)) {
            let v4 = 0x1::option::destroy_some<PricingSVI>(v3);
            let v5 = 1000000000;
            let v6 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts(narrow_input(v4.a_magnitude, true), v4.a_is_negative);
            v4.a_magnitude = (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v6) as u128) * v5;
            v4.a_is_negative = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&v6);
            v4.b = (narrow_input(v4.b, true) as u128) * v5;
            if (v4 == v0) {
                return v4
            };
        };
        v0
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

    fun var_ok(arg0: &PricingSVI) : bool {
        0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::var_positive(arg0.a_magnitude, arg0.a_is_negative, arg0.b, arg0.rho, arg0.sigma)
    }

    // decompiled from Move bytecode v7
}

