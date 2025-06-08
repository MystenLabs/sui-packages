module 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::oracle_aggregator {
    struct OracleAggregator<phantom T0> has store {
        price: PriceInfo,
        oracles: Oracles,
        latest_update_ms: u64,
        tolerance_ms: u64,
        is_active: bool,
    }

    struct PriceInfo has store {
        price: u64,
        decimals: u8,
    }

    struct Oracles has store {
        pyth: 0x1::option::Option<0x2::object::ID>,
        switchboard: 0x1::option::Option<0x2::object::ID>,
        supra: 0x1::option::Option<u32>,
    }

    struct PriceSources<phantom T0> has copy, drop {
        sources: 0x2::vec_map::VecMap<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>,
    }

    public(friend) fun activate_aggregator<T0>(arg0: &mut OracleAggregator<T0>) {
        arg0.is_active = true;
    }

    public fun add_price_from_pyth<T0>(arg0: &mut PriceSources<T0>, arg1: &OracleAggregator<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier) {
        if (0x1::option::is_none<0x2::object::ID>(&arg1.oracles.pyth)) {
            0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&mut arg0.sources, b"supra", 0x1::option::none<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>());
        };
        0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&mut arg0.sources, b"pyth", 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::pyth_price_fetcher::fetch_price<T0>(arg2, arg3, arg4, arg1.price.decimals, arg1.tolerance_ms));
    }

    public fun price_info<T0>(arg0: &OracleAggregator<T0>) : (u64, u8) {
        (arg0.price.price, arg0.price.decimals)
    }

    public fun add_price_from_supra<T0>(arg0: &mut PriceSources<T0>, arg1: &OracleAggregator<T0>, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: u32) {
        if (0x1::option::is_none<u32>(&arg1.oracles.supra)) {
            0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&mut arg0.sources, b"supra", 0x1::option::none<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>());
        };
        let v0 = 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::supra_price_fetcher::fetch_price<T0>(arg2, arg3, arg1.price.decimals);
        let v1 = if (0x1::option::is_none<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v0)) {
            0x1::option::none<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>()
        } else {
            0x1::option::some<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(0x1::option::destroy_some<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(v0))
        };
        0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&mut arg0.sources, b"supra", v1);
    }

    public fun add_price_from_switchboard<T0>(arg0: &mut PriceSources<T0>, arg1: &OracleAggregator<T0>, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        if (0x1::option::is_none<0x2::object::ID>(&arg1.oracles.switchboard)) {
            0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&mut arg0.sources, b"supra", 0x1::option::none<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>());
        };
        0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&mut arg0.sources, b"switchboard", 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::switchboard_price_fetcher::fetch_price<T0>(arg2, arg1.price.decimals));
    }

    public fun borrow_pyth<T0>(arg0: &OracleAggregator<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.oracles.pyth
    }

    public fun borrow_supra<T0>(arg0: &OracleAggregator<T0>) : &0x1::option::Option<u32> {
        &arg0.oracles.supra
    }

    public fun borrow_switchboard<T0>(arg0: &OracleAggregator<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.oracles.switchboard
    }

    public(friend) fun deactivate_aggregator<T0>(arg0: &mut OracleAggregator<T0>) {
        arg0.is_active = false;
    }

    fun err_no_valid_price() {
        abort 1
    }

    fun err_significant_price_diff() {
        abort 0
    }

    public fun is_active<T0>(arg0: &OracleAggregator<T0>) : bool {
        arg0.is_active
    }

    public fun latest_update_ms<T0>(arg0: &OracleAggregator<T0>) : u64 {
        arg0.latest_update_ms
    }

    public(friend) fun new<T0>(arg0: 0x1::option::Option<address>, arg1: 0x1::option::Option<address>, arg2: 0x1::option::Option<u32>, arg3: u8, arg4: u64) : OracleAggregator<T0> {
        let v0 = if (0x1::option::is_some<address>(&arg0)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg0)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v1 = if (0x1::option::is_some<address>(&arg1)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg1)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v2 = PriceInfo{
            price    : 0,
            decimals : arg3,
        };
        let v3 = Oracles{
            pyth        : v0,
            switchboard : v1,
            supra       : arg2,
        };
        OracleAggregator<T0>{
            price            : v2,
            oracles          : v3,
            latest_update_ms : 0,
            tolerance_ms     : arg4,
            is_active        : false,
        }
    }

    public fun new_price_sources<T0>() : PriceSources<T0> {
        PriceSources<T0>{sources: 0x2::vec_map::empty<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>()}
    }

    public fun oracle_amount<T0>(arg0: &OracleAggregator<T0>) : u64 {
        let v0 = 0;
        let v1 = v0;
        if (0x1::option::is_some<0x2::object::ID>(&arg0.oracles.pyth)) {
            v1 = v0 + 1;
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg0.oracles.switchboard)) {
            v1 = v1 + 1;
        };
        if (0x1::option::is_some<u32>(&arg0.oracles.supra)) {
            v1 = v1 + 1;
        };
        v1
    }

    public(friend) fun set_pyth<T0>(arg0: &mut OracleAggregator<T0>, arg1: 0x1::option::Option<address>) {
        let v0 = if (0x1::option::is_some<address>(&arg1)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg1)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        arg0.oracles.switchboard = v0;
    }

    public(friend) fun set_supra<T0>(arg0: &mut OracleAggregator<T0>, arg1: 0x1::option::Option<u32>) {
        arg0.oracles.supra = arg1;
    }

    public(friend) fun set_switchboard<T0>(arg0: &mut OracleAggregator<T0>, arg1: 0x1::option::Option<address>) {
        let v0 = if (0x1::option::is_some<address>(&arg1)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg1)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        arg0.oracles.switchboard = v0;
    }

    public fun tolerance_ms<T0>(arg0: &OracleAggregator<T0>) : u64 {
        arg0.tolerance_ms
    }

    public fun update_price<T0>(arg0: &mut OracleAggregator<T0>, arg1: &0x2::clock::Clock, arg2: PriceSources<T0>) {
        let v0 = 0x1::vector::empty<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>();
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = arg2.sources;
        let v3 = b"pyth";
        if (0x2::vec_map::contains<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&v2, &v3)) {
            let v4 = b"pyth";
            let (_, v6) = 0x2::vec_map::remove<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&mut v2, &v4);
            let v7 = v6;
            if (0x1::option::is_some<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v7)) {
                let v8 = 0x1::option::destroy_some<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(v7);
                if (v1 - 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::timestamp_ms<T0>(&v8) <= arg0.tolerance_ms) {
                    0x1::vector::push_back<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&mut v0, v8);
                };
            };
        };
        let v9 = b"switchboard";
        if (0x2::vec_map::contains<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&v2, &v9)) {
            let v10 = b"switchboard";
            let (_, v12) = 0x2::vec_map::remove<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&mut v2, &v10);
            let v13 = v12;
            if (0x1::option::is_some<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v13)) {
                let v14 = 0x1::option::destroy_some<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(v13);
                if (v1 - 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::timestamp_ms<T0>(&v14) <= arg0.tolerance_ms) {
                    0x1::vector::push_back<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&mut v0, v14);
                };
            };
        };
        let v15 = b"supra";
        if (0x2::vec_map::contains<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&v2, &v15)) {
            let v16 = b"switchboard";
            let (_, v18) = 0x2::vec_map::remove<vector<u8>, 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>>(&mut v2, &v16);
            let v19 = v18;
            if (0x1::option::is_some<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v19)) {
                let v20 = 0x1::option::destroy_some<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(v19);
                if (v1 - 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::timestamp_ms<T0>(&v20) <= arg0.tolerance_ms) {
                    0x1::vector::push_back<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&mut v0, v20);
                };
            };
        };
        if (0x1::vector::length<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v0) == 0) {
            err_no_valid_price();
        };
        let v21 = if (0x1::vector::length<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v0) == 1) {
            0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::price<T0>(0x1::vector::borrow<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v0, 0))
        } else if (0x1::vector::length<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v0) == 2) {
            let v22 = 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::price<T0>(0x1::vector::borrow<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v0, 0));
            let v23 = 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::price<T0>(0x1::vector::borrow<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v0, 1));
            let v24 = (v22 + v23) / 2;
            if (0x1::u64::diff(v22, v23) * 50 > v24) {
                err_significant_price_diff();
            };
            v24
        } else {
            let v25 = 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::price<T0>(0x1::vector::borrow<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v0, 0));
            let v26 = 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::price<T0>(0x1::vector::borrow<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v0, 1));
            let v27 = 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::price<T0>(0x1::vector::borrow<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(&v0, 2));
            let v28 = (v25 + v26 + v27) / 3;
            let v29 = if (0x1::u64::diff(v25, v26) * 50 > v28) {
                true
            } else if (0x1::u64::diff(v25, v27) * 50 > v28) {
                true
            } else {
                0x1::u64::diff(v26, v27) * 50 > v28
            };
            if (v29) {
                err_significant_price_diff();
            };
            v28
        };
        arg0.price.price = v21;
        arg0.latest_update_ms = v1;
    }

    public fun update_tolerance_ms<T0>(arg0: &mut OracleAggregator<T0>, arg1: u64) {
        arg0.tolerance_ms = arg1;
    }

    // decompiled from Move bytecode v6
}

