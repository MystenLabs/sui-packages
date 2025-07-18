module 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::oracle_aggregator {
    struct OracleAggregator has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::ascii::String,
        price: PriceInfo,
        oracles: Oracles,
        latest_update_ms: u64,
        tolerance_ms: u64,
        is_active: bool,
    }

    struct PriceInfo has copy, drop, store {
        price: u64,
        decimals: u8,
    }

    struct Oracles has store {
        pyth: 0x1::option::Option<0x2::object::ID>,
        switchboard: 0x1::option::Option<0x2::object::ID>,
        supra: 0x1::option::Option<u32>,
    }

    struct PriceSources has copy, drop {
        coin_type: 0x1::ascii::String,
        sources: 0x2::vec_map::VecMap<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>,
    }

    struct WhitelistRule<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0x1::ascii::String, arg1: 0x1::option::Option<address>, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<u32>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : OracleAggregator {
        let v0 = if (0x1::option::is_some<address>(&arg1)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg1)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v1 = if (0x1::option::is_some<address>(&arg2)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg2)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v2 = PriceInfo{
            price    : 0,
            decimals : arg4,
        };
        let v3 = Oracles{
            pyth        : v0,
            switchboard : v1,
            supra       : arg3,
        };
        OracleAggregator{
            id               : 0x2::object::new(arg6),
            coin_type        : arg0,
            price            : v2,
            oracles          : v3,
            latest_update_ms : 0,
            tolerance_ms     : arg5,
            is_active        : false,
        }
    }

    public fun price(arg0: &PriceInfo) : u64 {
        arg0.price
    }

    public(friend) fun activate_aggregator(arg0: &mut OracleAggregator) {
        arg0.is_active = true;
    }

    public fun add_price_from_pyth(arg0: &mut PriceSources, arg1: 0x1::type_name::TypeName, arg2: &OracleAggregator, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        if (0x1::option::is_none<0x2::object::ID>(&arg2.oracles.pyth)) {
            0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&mut arg0.sources, b"pyth", 0x1::option::none<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>());
        };
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3);
        if (0x1::option::borrow<0x2::object::ID>(&arg2.oracles.pyth) != &v0) {
            err_wrong_source();
        };
        0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&mut arg0.sources, b"pyth", 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::pyth_price_fetcher::fetch_price(0x1::type_name::into_string(arg1), arg3, arg4, arg2.price.decimals, arg2.tolerance_ms));
    }

    public fun price_info(arg0: &OracleAggregator) : PriceInfo {
        arg0.price
    }

    public fun add_price_from_supra(arg0: &mut PriceSources, arg1: 0x1::type_name::TypeName, arg2: &OracleAggregator, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: u32) {
        if (0x1::option::is_none<u32>(&arg2.oracles.supra)) {
            0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&mut arg0.sources, b"supra", 0x1::option::none<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>());
        };
        if (0x1::option::borrow<u32>(&arg2.oracles.supra) != &arg4) {
            err_wrong_source();
        };
        let v0 = 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::supra_price_fetcher::fetch_price(0x1::type_name::into_string(arg1), arg3, arg4, arg2.price.decimals);
        let v1 = if (0x1::option::is_none<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v0)) {
            0x1::option::none<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>()
        } else {
            0x1::option::some<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(0x1::option::destroy_some<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(v0))
        };
        0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&mut arg0.sources, b"supra", v1);
    }

    public fun add_price_from_switchboard(arg0: &mut PriceSources, arg1: 0x1::type_name::TypeName, arg2: &OracleAggregator, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        if (0x1::option::is_none<0x2::object::ID>(&arg2.oracles.switchboard)) {
            0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&mut arg0.sources, b"switchboard", 0x1::option::none<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>());
        };
        let v0 = 0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg3);
        if (0x1::option::borrow<0x2::object::ID>(&arg2.oracles.switchboard) != &v0) {
            err_wrong_source();
        };
        0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&mut arg0.sources, b"switchboard", 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::switchboard_price_fetcher::fetch_price(0x1::type_name::into_string(arg1), arg3, arg2.price.decimals));
    }

    public(friend) fun add_rule<T0: drop>(arg0: &mut OracleAggregator) {
        let v0 = WhitelistRule<T0>{dummy_field: false};
        0x2::dynamic_field::add<WhitelistRule<T0>, bool>(&mut arg0.id, v0, true);
    }

    public fun borrow_pyth(arg0: &OracleAggregator) : &0x1::option::Option<0x2::object::ID> {
        &arg0.oracles.pyth
    }

    public fun borrow_supra(arg0: &OracleAggregator) : &0x1::option::Option<u32> {
        &arg0.oracles.supra
    }

    public fun borrow_switchboard(arg0: &OracleAggregator) : &0x1::option::Option<0x2::object::ID> {
        &arg0.oracles.switchboard
    }

    public(friend) fun deactivate_aggregator(arg0: &mut OracleAggregator) {
        arg0.is_active = false;
    }

    public fun decimals(arg0: &PriceInfo) : u8 {
        arg0.decimals
    }

    fun err_no_valid_price() {
        abort 1
    }

    fun err_rule_not_supported() {
        abort 3
    }

    fun err_significant_price_diff() {
        abort 0
    }

    fun err_wrong_source() {
        abort 2
    }

    public fun is_active(arg0: &OracleAggregator) : bool {
        arg0.is_active
    }

    public fun latest_update_ms(arg0: &OracleAggregator) : u64 {
        arg0.latest_update_ms
    }

    public fun new_price_sources(arg0: 0x1::type_name::TypeName) : PriceSources {
        PriceSources{
            coin_type : 0x1::type_name::into_string(arg0),
            sources   : 0x2::vec_map::empty<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(),
        }
    }

    public fun oracle_amount(arg0: &OracleAggregator) : u64 {
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

    public(friend) fun remove_rule<T0: drop>(arg0: &mut OracleAggregator) {
        let v0 = WhitelistRule<T0>{dummy_field: false};
        0x2::dynamic_field::remove<WhitelistRule<T0>, bool>(&mut arg0.id, v0);
    }

    public(friend) fun set_pyth(arg0: &mut OracleAggregator, arg1: 0x1::option::Option<address>) {
        let v0 = if (0x1::option::is_some<address>(&arg1)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg1)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        arg0.oracles.switchboard = v0;
    }

    public(friend) fun set_supra(arg0: &mut OracleAggregator, arg1: 0x1::option::Option<u32>) {
        arg0.oracles.supra = arg1;
    }

    public(friend) fun set_switchboard(arg0: &mut OracleAggregator, arg1: 0x1::option::Option<address>) {
        let v0 = if (0x1::option::is_some<address>(&arg1)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg1)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        arg0.oracles.switchboard = v0;
    }

    public fun tolerance_ms(arg0: &OracleAggregator) : u64 {
        arg0.tolerance_ms
    }

    public fun update_oracle_price_with_rule<T0: drop>(arg0: &mut OracleAggregator, arg1: T0, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = WhitelistRule<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<WhitelistRule<T0>>(&arg0.id, v0)) {
            err_rule_not_supported();
        };
        arg0.price.price = arg3;
        arg0.latest_update_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public fun update_price(arg0: &mut OracleAggregator, arg1: &0x2::clock::Clock, arg2: PriceSources) {
        let v0 = 0x1::vector::empty<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>();
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = arg2.sources;
        let v3 = b"pyth";
        if (0x2::vec_map::contains<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&v2, &v3)) {
            let v4 = b"pyth";
            let (_, v6) = 0x2::vec_map::remove<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&mut v2, &v4);
            let v7 = v6;
            if (0x1::option::is_some<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v7)) {
                let v8 = 0x1::option::destroy_some<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(v7);
                if (v1 - 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::timestamp_ms(&v8) <= arg0.tolerance_ms) {
                    0x1::vector::push_back<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&mut v0, v8);
                };
            };
        };
        let v9 = b"switchboard";
        if (0x2::vec_map::contains<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&v2, &v9)) {
            let v10 = b"switchboard";
            let (_, v12) = 0x2::vec_map::remove<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&mut v2, &v10);
            let v13 = v12;
            if (0x1::option::is_some<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v13)) {
                let v14 = 0x1::option::destroy_some<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(v13);
                if (v1 - 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::timestamp_ms(&v14) <= arg0.tolerance_ms) {
                    0x1::vector::push_back<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&mut v0, v14);
                };
            };
        };
        let v15 = b"supra";
        if (0x2::vec_map::contains<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&v2, &v15)) {
            let v16 = b"supra";
            let (_, v18) = 0x2::vec_map::remove<vector<u8>, 0x1::option::Option<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>>(&mut v2, &v16);
            let v19 = v18;
            if (0x1::option::is_some<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v19)) {
                let v20 = 0x1::option::destroy_some<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(v19);
                if (v1 - 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::timestamp_ms(&v20) <= arg0.tolerance_ms) {
                    0x1::vector::push_back<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&mut v0, v20);
                };
            };
        };
        if (0x1::vector::length<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v0) == 0) {
            err_no_valid_price();
        };
        let v21 = if (0x1::vector::length<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v0) == 1) {
            0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::price(0x1::vector::borrow<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v0, 0))
        } else if (0x1::vector::length<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v0) == 2) {
            let v22 = 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::price(0x1::vector::borrow<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v0, 0));
            let v23 = 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::price(0x1::vector::borrow<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v0, 1));
            let v24 = (v22 + v23) / 2;
            if (0x1::u64::diff(v22, v23) * 50 > v24) {
                err_significant_price_diff();
            };
            v24
        } else {
            let v25 = 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::price(0x1::vector::borrow<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v0, 0));
            let v26 = 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::price(0x1::vector::borrow<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v0, 1));
            let v27 = 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::price(0x1::vector::borrow<0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::current_price::CurrentPrice>(&v0, 2));
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

    public fun update_tolerance_ms(arg0: &mut OracleAggregator, arg1: u64) {
        arg0.tolerance_ms = arg1;
    }

    // decompiled from Move bytecode v6
}

