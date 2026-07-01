module 0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::loaf_oracle {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LoafOracle has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct PriceType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_rule<T0, T1: drop>(arg0: &AdminCap, arg1: &mut LoafOracle) {
        0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::add_rule<T0, T1>(borrow_single_oracle_mut<T0>(arg1));
    }

    public fun borrow_single_oracle<T0>(arg0: &LoafOracle) : &0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::SingleOracle<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = PriceType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<PriceType<T0>, 0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::SingleOracle<T0>>(&arg0.id, v0)
    }

    public fun borrow_single_oracle_mut<T0>(arg0: &mut LoafOracle) : &mut 0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::SingleOracle<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = PriceType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PriceType<T0>, 0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::SingleOracle<T0>>(&mut arg0.id, v0)
    }

    public entry fun create_single_oracle<T0>(arg0: &AdminCap, arg1: &mut LoafOracle, arg2: u8, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceType<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<PriceType<T0>, 0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::SingleOracle<T0>>(&mut arg1.id, v0, 0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::new<T0>(arg2, arg3, arg4, arg5, arg6));
    }

    public fun get_price<T0>(arg0: &LoafOracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(arg0.version == 1, 99);
        0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::get_price<T0>(borrow_single_oracle<T0>(arg0), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_oracle(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        create_single_oracle<0x2::sui::SUI>(&v2, v4, 9, 3600000, 1, 0x1::option::some<address>(@0x168aa44fa92b27358beb17643834078b1320be6adf1b3bb0c7f018ac3591db1a), arg0);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<LoafOracle>(v3);
    }

    fun new_oracle(arg0: &mut 0x2::tx_context::TxContext) : (LoafOracle, AdminCap) {
        let v0 = LoafOracle{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun remove_rule<T0, T1: drop>(arg0: &AdminCap, arg1: &mut LoafOracle) {
        0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::remove_rule<T0, T1>(borrow_single_oracle_mut<T0>(arg1));
    }

    public entry fun update_package_version<T0>(arg0: &AdminCap, arg1: &mut LoafOracle, arg2: u64) {
        arg1.version = arg2;
    }

    public entry fun update_price_from_pyth<T0>(arg0: &mut LoafOracle, arg1: &0x2::clock::Clock, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg4: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.version == 1, 99);
        let v0 = borrow_single_oracle_mut<T0>(arg0);
        let v1 = 0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::issue_price_collector<T0>();
        0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::collect_price_from_pyth<T0>(v0, &mut v1, arg1, arg2, arg3, arg4, arg5, arg6);
        0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::update_oracle_price<T0>(v0, arg1, v1);
    }

    public entry fun update_price_from_pyth_read_only<T0>(arg0: &mut LoafOracle, arg1: &0x2::clock::Clock, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg3: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) {
        assert!(arg0.version == 1, 99);
        let v0 = borrow_single_oracle_mut<T0>(arg0);
        let v1 = 0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::issue_price_collector<T0>();
        0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::collect_price_from_pyth_read_only<T0>(v0, &mut v1, arg1, arg2, arg3);
        0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::update_oracle_price<T0>(v0, arg1, v1);
    }

    public entry fun update_pyth_config<T0>(arg0: &AdminCap, arg1: &mut LoafOracle, arg2: 0x1::option::Option<address>) {
        0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::update_pyth_config<T0>(borrow_single_oracle_mut<T0>(arg1), arg2);
    }

    public entry fun update_threshold<T0>(arg0: &AdminCap, arg1: &mut LoafOracle, arg2: u64) {
        0xbaf9edb2cf2de4eb9d6eea9065c7a665178e528e0461b19e0caa8a1cdb845174::single_oracle::update_threshold<T0>(borrow_single_oracle_mut<T0>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

