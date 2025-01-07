module 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct BucketOracle has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct PriceType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow_single_oracle<T0>(arg0: &BucketOracle) : &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::SingleOracle<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = PriceType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<PriceType<T0>, 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::SingleOracle<T0>>(&arg0.id, v0)
    }

    public fun borrow_single_oracle_mut<T0>(arg0: &mut BucketOracle) : &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::SingleOracle<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = PriceType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PriceType<T0>, 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::SingleOracle<T0>>(&mut arg0.id, v0)
    }

    public entry fun create_single_oracle<T0>(arg0: &AdminCap, arg1: &mut BucketOracle, arg2: u8, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: 0x1::option::Option<address>, arg7: 0x1::option::Option<u32>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceType<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<PriceType<T0>, 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::SingleOracle<T0>>(&mut arg1.id, v0, 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::new<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public fun get_price<T0>(arg0: &BucketOracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(arg0.version == 1, 99);
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::get_price<T0>(borrow_single_oracle<T0>(arg0), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_oracle(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        create_single_oracle<0x2::sui::SUI>(&v2, v4, 6, 3600000, 1, 0x1::option::some<address>(@0xbca474133638352ba83ccf7b5c931d50f764b09550e16612c9f70f1e21f3f594), 0x1::option::some<address>(@0x168aa44fa92b27358beb17643834078b1320be6adf1b3bb0c7f018ac3591db1a), 0x1::option::some<u32>(90), arg0);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<BucketOracle>(v3);
    }

    fun new_oracle(arg0: &mut 0x2::tx_context::TxContext) : (BucketOracle, AdminCap) {
        let v0 = BucketOracle{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public entry fun update_package_version<T0>(arg0: &AdminCap, arg1: &mut BucketOracle, arg2: u64) {
        arg1.version = arg2;
    }

    public entry fun update_price_from_pyth<T0>(arg0: &mut BucketOracle, arg1: &0x2::clock::Clock, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg4: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.version == 1, 99);
        let v0 = borrow_single_oracle_mut<T0>(arg0);
        let v1 = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::issue_price_collector<T0>();
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::collect_price_from_pyth<T0>(v0, &mut v1, arg1, arg2, arg3, arg4, arg5, arg6);
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price<T0>(v0, arg1, v1);
    }

    public entry fun update_price_from_pyth_read_only<T0>(arg0: &mut BucketOracle, arg1: &0x2::clock::Clock, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg3: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) {
        assert!(arg0.version == 1, 99);
        let v0 = borrow_single_oracle_mut<T0>(arg0);
        let v1 = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::issue_price_collector<T0>();
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::collect_price_from_pyth_read_only<T0>(v0, &mut v1, arg1, arg2, arg3);
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price<T0>(v0, arg1, v1);
    }

    public entry fun update_price_from_switchboard<T0>(arg0: &mut BucketOracle, arg1: &0x2::clock::Clock, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) {
        assert!(arg0.version == 1, 99);
        let v0 = borrow_single_oracle_mut<T0>(arg0);
        let v1 = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::issue_price_collector<T0>();
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::collect_price_from_switchboard<T0>(v0, &mut v1, arg2);
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price<T0>(v0, arg1, v1);
    }

    public entry fun update_pyth_config<T0>(arg0: &AdminCap, arg1: &mut BucketOracle, arg2: 0x1::option::Option<address>) {
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_pyth_config<T0>(borrow_single_oracle_mut<T0>(arg1), arg2);
    }

    public entry fun update_supra_config<T0>(arg0: &AdminCap, arg1: &mut BucketOracle, arg2: 0x1::option::Option<u32>) {
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_supra_config<T0>(borrow_single_oracle_mut<T0>(arg1), arg2);
    }

    public entry fun update_switchboard_config<T0>(arg0: &AdminCap, arg1: &mut BucketOracle, arg2: 0x1::option::Option<address>) {
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_switchboard_config<T0>(borrow_single_oracle_mut<T0>(arg1), arg2);
    }

    public entry fun update_threshold<T0>(arg0: &AdminCap, arg1: &mut BucketOracle, arg2: u64) {
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_threshold<T0>(borrow_single_oracle_mut<T0>(arg1), arg2);
    }

    // decompiled from Move bytecode v6
}

