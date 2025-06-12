module 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::stingray_oracle {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StingrayOracle has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        asset_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun update_tolerance_ms(arg0: &mut StingrayOracle, arg1: u64, arg2: 0x1::type_name::TypeName) {
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::update_tolerance_ms(borrow_oracle_aggregator_mut(arg0, arg2), arg1);
    }

    public fun activate(arg0: &mut StingrayOracle, arg1: 0x1::type_name::TypeName) {
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::deactivate_aggregator(borrow_oracle_aggregator_mut(arg0, arg1));
    }

    public fun add_version(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            err_version_already_existed();
        };
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    public fun borrow_oracle_aggregator(arg0: &StingrayOracle, arg1: 0x1::type_name::TypeName) : &0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::OracleAggregator {
        if (!is_version_allowed(arg0)) {
            err_version_not_allowed();
        };
        let v0 = 0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::OracleAggregator>(&arg0.id, arg1);
        if (!0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::is_active(v0)) {
            err_oracle_aggregator_not_active();
        };
        v0
    }

    public fun borrow_oracle_aggregator_mut(arg0: &mut StingrayOracle, arg1: 0x1::type_name::TypeName) : &mut 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::OracleAggregator {
        if (!is_version_allowed(arg0)) {
            err_version_not_allowed();
        };
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::OracleAggregator>(&mut arg0.id, arg1);
        if (!0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::is_active(v0)) {
            err_oracle_aggregator_not_active();
        };
        v0
    }

    public fun deactivate(arg0: &mut StingrayOracle, arg1: 0x1::type_name::TypeName) {
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::activate_aggregator(borrow_oracle_aggregator_mut(arg0, arg1));
    }

    fun err_asset_already_existed() {
        abort 1
    }

    fun err_oracle_aggregator_not_active() {
        abort 2
    }

    fun err_price_expired() {
        abort 0
    }

    fun err_version_already_existed() {
        abort 4
    }

    fun err_version_not_allowed() {
        abort 5
    }

    fun err_version_not_existed() {
        abort 3
    }

    public fun get_price(arg0: &StingrayOracle, arg1: &0x2::clock::Clock, arg2: 0x1::type_name::TypeName) : (u64, u8) {
        let v0 = borrow_oracle_aggregator(arg0, arg2);
        if (0x2::clock::timestamp_ms(arg1) - 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::latest_update_ms(v0) > 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::tolerance_ms(v0)) {
            err_price_expired();
        };
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::price_info(v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_oracle(arg0);
        0x2::transfer::share_object<StingrayOracle>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_price_supported(arg0: &StingrayOracle, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.asset_types, &arg1) && 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::is_active(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::OracleAggregator>(&arg0.id, arg1))
    }

    public fun is_version_allowed(arg0: &StingrayOracle) : bool {
        let v0 = 1;
        0x2::vec_set::contains<u64>(&arg0.versions, &v0)
    }

    fun new_oracle(arg0: &mut 0x2::tx_context::TxContext) : (StingrayOracle, AdminCap) {
        let v0 = StingrayOracle{
            id          : 0x2::object::new(arg0),
            versions    : 0x2::vec_set::singleton<u64>(1),
            asset_types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun new_oracle_aggregator<T0>(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<u32>, arg5: u8, arg6: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            err_asset_already_existed();
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.asset_types, v0);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::OracleAggregator>(&mut arg0.id, v0, 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::new(0x1::type_name::get<T0>(), arg2, arg3, arg4, arg5, arg6));
    }

    public fun remove_version(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            err_version_not_existed();
        };
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public fun update_price_from_pyth(arg0: &mut StingrayOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, arg4: 0x1::type_name::TypeName) {
        let v0 = borrow_oracle_aggregator_mut(arg0, arg4);
        let v1 = 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::new_price_sources(arg4);
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::add_price_from_pyth(&mut v1, arg4, v0, arg1, arg2, arg3);
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::update_price(v0, arg2, v1);
    }

    public fun update_price_from_supra(arg0: &mut StingrayOracle, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: u32, arg3: &0x2::clock::Clock, arg4: 0x1::type_name::TypeName) {
        let v0 = borrow_oracle_aggregator_mut(arg0, arg4);
        let v1 = 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::new_price_sources(arg4);
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::add_price_from_supra(&mut v1, arg4, v0, arg1, arg2);
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::update_price(v0, arg3, v1);
    }

    public fun update_price_from_switchboard(arg0: &mut StingrayOracle, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0x2::clock::Clock, arg3: 0x1::type_name::TypeName) {
        let v0 = borrow_oracle_aggregator_mut(arg0, arg3);
        let v1 = 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::new_price_sources(arg3);
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::add_price_from_switchboard(&mut v1, arg3, v0, arg1);
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::update_price(v0, arg2, v1);
    }

    public fun update_pyth(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: 0x1::option::Option<address>, arg3: 0x1::type_name::TypeName) {
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::set_pyth(borrow_oracle_aggregator_mut(arg0, arg3), arg2);
    }

    public fun update_supra(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: 0x1::option::Option<u32>, arg3: 0x1::type_name::TypeName) {
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::set_supra(borrow_oracle_aggregator_mut(arg0, arg3), arg2);
    }

    public fun update_switchboard(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: 0x1::option::Option<address>, arg3: 0x1::type_name::TypeName) {
        0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::oracle_aggregator::set_switchboard(borrow_oracle_aggregator_mut(arg0, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

