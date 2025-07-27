module 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::stingray_oracle {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StingrayOracle has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        asset_types: 0x2::vec_set::VecSet<0x1::ascii::String>,
    }

    public fun add_rule<T0, T1: drop>(arg0: &mut StingrayOracle, arg1: &AdminCap) {
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::add_rule<T1>(borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<T0>())));
    }

    public fun remove_rule<T0, T1: drop>(arg0: &mut StingrayOracle, arg1: &AdminCap) {
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::remove_rule<T1>(borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<T0>())));
    }

    public fun update_tolerance_ms<T0>(arg0: &mut StingrayOracle, arg1: u64) {
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::update_tolerance_ms(borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<T0>())), arg1);
    }

    public fun activate<T0>(arg0: &mut StingrayOracle) {
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::activate_aggregator(borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<T0>())));
    }

    public fun add_version(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            err_version_already_existed();
        };
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    public fun borrow_oracle_aggregator(arg0: &StingrayOracle, arg1: 0x1::ascii::String) : &0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::OracleAggregator {
        if (!is_version_allowed(arg0)) {
            err_version_not_allowed();
        };
        0x2::dynamic_field::borrow<0x1::ascii::String, 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::OracleAggregator>(&arg0.id, arg1)
    }

    public fun borrow_oracle_aggregator_mut(arg0: &mut StingrayOracle, arg1: 0x1::ascii::String) : &mut 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::OracleAggregator {
        if (!is_version_allowed(arg0)) {
            err_version_not_allowed();
        };
        0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::OracleAggregator>(&mut arg0.id, arg1)
    }

    public fun deactivate<T0>(arg0: &mut StingrayOracle) {
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::deactivate_aggregator(borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<T0>())));
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

    public fun get_price(arg0: &StingrayOracle, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String) : 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::PriceInfo {
        let v0 = borrow_oracle_aggregator(arg0, arg2);
        if (!0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::is_active(v0)) {
            err_oracle_aggregator_not_active();
        };
        if (0x2::clock::timestamp_ms(arg1) - 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::latest_update_ms(v0) > 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::tolerance_ms(v0)) {
            err_price_expired();
        };
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::price_info(v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_oracle(arg0);
        0x2::transfer::share_object<StingrayOracle>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_price_supported(arg0: &StingrayOracle, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0x1::type_name::into_string(arg1);
        0x2::vec_set::contains<0x1::ascii::String>(&arg0.asset_types, &v0) && 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::is_active(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::OracleAggregator>(&arg0.id, arg1))
    }

    public fun is_version_allowed(arg0: &StingrayOracle) : bool {
        let v0 = 1;
        0x2::vec_set::contains<u64>(&arg0.versions, &v0)
    }

    fun new_oracle(arg0: &mut 0x2::tx_context::TxContext) : (StingrayOracle, AdminCap) {
        let v0 = StingrayOracle{
            id          : 0x2::object::new(arg0),
            versions    : 0x2::vec_set::singleton<u64>(1),
            asset_types : 0x2::vec_set::empty<0x1::ascii::String>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun new_oracle_aggregator<T0>(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<u32>, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            err_asset_already_existed();
        };
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.asset_types, 0x1::type_name::into_string(v0));
        0x2::dynamic_field::add<0x1::ascii::String, 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::OracleAggregator>(&mut arg0.id, 0x1::type_name::into_string(v0), 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::new(0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public fun remove_version(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            err_version_not_existed();
        };
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public fun update_price_by_pyth<T0>(arg0: &mut StingrayOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(v0));
        let v2 = 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::new_price_sources(v0);
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::add_price_from_pyth(&mut v2, v0, v1, arg1, arg2);
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::update_price(v1, arg2, v2);
    }

    public fun update_price_by_supra<T0>(arg0: &mut StingrayOracle, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: u32, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(v0));
        let v2 = 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::new_price_sources(v0);
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::add_price_from_supra(&mut v2, v0, v1, arg1, arg2);
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::update_price(v1, arg3, v2);
    }

    public fun update_price_by_switchboard<T0>(arg0: &mut StingrayOracle, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(v0));
        let v2 = 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::new_price_sources(v0);
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::add_price_from_switchboard(&mut v2, v0, v1, arg1);
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::update_price(v1, arg2, v2);
    }

    public fun update_pyth<T0>(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: 0x1::option::Option<address>) {
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::set_pyth(borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<T0>())), arg2);
    }

    public fun update_supra<T0>(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: 0x1::option::Option<u32>) {
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::set_supra(borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<T0>())), arg2);
    }

    public fun update_switchboard<T0>(arg0: &mut StingrayOracle, arg1: &AdminCap, arg2: 0x1::option::Option<address>) {
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::set_switchboard(borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<T0>())), arg2);
    }

    // decompiled from Move bytecode v6
}

