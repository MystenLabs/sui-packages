module 0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::single_oracle {
    struct ParsePriceEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        source_id: u8,
        price_info: 0x1::option::Option<0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::PriceInfo>,
    }

    struct SingleOracle<phantom T0> has store, key {
        id: 0x2::object::UID,
        price: u64,
        precision_decimal: u8,
        precision: u64,
        tolerance_ms: u64,
        threshold: u64,
        latest_update_ms: u64,
        switchboard_config: 0x1::option::Option<0x2::object::ID>,
        pyth_config: 0x1::option::Option<0x2::object::ID>,
        supra_config: 0x1::option::Option<u32>,
    }

    struct PriceCollector<phantom T0> {
        switchboard_result: 0x1::option::Option<0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::PriceInfo>,
        pyth_result: 0x1::option::Option<0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::PriceInfo>,
        supra_result: 0x1::option::Option<0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::PriceInfo>,
    }

    public(friend) fun new<T0>(arg0: u8, arg1: u64, arg2: u64, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<address>, arg5: 0x1::option::Option<u32>, arg6: &mut 0x2::tx_context::TxContext) : SingleOracle<T0> {
        SingleOracle<T0>{
            id                 : 0x2::object::new(arg6),
            price              : 0,
            precision_decimal  : arg0,
            precision          : 0x2::math::pow(10, arg0),
            tolerance_ms       : arg1,
            threshold          : arg2,
            latest_update_ms   : 0,
            switchboard_config : 0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::switchboard_parser::parse_config(arg3),
            pyth_config        : 0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::pyth_parser::parse_config(arg4),
            supra_config       : arg5,
        }
    }

    public fun collect_price_from_pyth<T0>(arg0: &SingleOracle<T0>, arg1: &mut PriceCollector<T0>, arg2: &0x2::clock::Clock, arg3: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg5: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: vector<u8>, arg7: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pyth_config), 0);
        let v0 = 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg5);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.pyth_config) == &v0, 1);
        let v1 = 0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::pyth_parser::parse_price(arg3, arg4, arg2, arg5, arg6, arg7, arg0.precision_decimal);
        let v2 = ParsePriceEvent{
            coin_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            source_id  : 1,
            price_info : v1,
        };
        0x2::event::emit<ParsePriceEvent>(v2);
        arg1.pyth_result = v1;
    }

    public fun collect_price_from_switchboard<T0>(arg0: &SingleOracle<T0>, arg1: &mut PriceCollector<T0>, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.switchboard_config), 0);
        let v0 = 0x2::object::id<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg2);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.switchboard_config) == &v0, 1);
        let v1 = 0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::switchboard_parser::parse_price(arg2, arg0.precision_decimal);
        let v2 = ParsePriceEvent{
            coin_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            source_id  : 0,
            price_info : v1,
        };
        0x2::event::emit<ParsePriceEvent>(v2);
        arg1.switchboard_result = v1;
    }

    public fun get_price<T0>(arg0: &SingleOracle<T0>, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.latest_update_ms <= 10000, 2);
        (arg0.price, arg0.precision)
    }

    public fun issue_price_collector<T0>() : PriceCollector<T0> {
        PriceCollector<T0>{
            switchboard_result : 0x1::option::none<0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::PriceInfo>(),
            pyth_result        : 0x1::option::none<0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::PriceInfo>(),
            supra_result       : 0x1::option::none<0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::PriceInfo>(),
        }
    }

    public fun update_oracle_price<T0>(arg0: &mut SingleOracle<T0>, arg1: &0x2::clock::Clock, arg2: PriceCollector<T0>) {
        let v0 = 0x1::vector::empty<0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::PriceInfo>();
        let PriceCollector {
            switchboard_result : v1,
            pyth_result        : v2,
            supra_result       : v3,
        } = arg2;
        0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::push_price(&mut v0, v1);
        0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::push_price(&mut v0, v2);
        0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::push_price(&mut v0, v3);
        arg0.price = 0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::price_aggregator::aggregate_price(arg1, v0, arg0.tolerance_ms, arg0.threshold);
        arg0.latest_update_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun update_pyth_config<T0>(arg0: &mut SingleOracle<T0>, arg1: 0x1::option::Option<address>) {
        arg0.pyth_config = 0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::pyth_parser::parse_config(arg1);
    }

    public(friend) fun update_supra_config<T0>(arg0: &mut SingleOracle<T0>, arg1: 0x1::option::Option<u32>) {
        arg0.supra_config = arg1;
    }

    public(friend) fun update_switchboard_config<T0>(arg0: &mut SingleOracle<T0>, arg1: 0x1::option::Option<address>) {
        arg0.switchboard_config = 0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::switchboard_parser::parse_config(arg1);
    }

    public(friend) fun update_threshold<T0>(arg0: &mut SingleOracle<T0>, arg1: u64) {
        arg0.threshold = arg1;
    }

    // decompiled from Move bytecode v6
}

