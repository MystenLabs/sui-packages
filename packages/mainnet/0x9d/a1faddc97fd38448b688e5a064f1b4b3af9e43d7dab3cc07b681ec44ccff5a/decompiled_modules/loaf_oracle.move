module 0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle {
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
        0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::add_rule<T0, T1>(borrow_single_oracle_mut<T0>(arg1));
    }

    public fun borrow_single_oracle<T0>(arg0: &LoafOracle) : &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::SingleOracle<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = PriceType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<PriceType<T0>, 0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::SingleOracle<T0>>(&arg0.id, v0)
    }

    public fun borrow_single_oracle_mut<T0>(arg0: &mut LoafOracle) : &mut 0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::SingleOracle<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = PriceType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PriceType<T0>, 0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::SingleOracle<T0>>(&mut arg0.id, v0)
    }

    public entry fun create_single_oracle<T0>(arg0: &AdminCap, arg1: &mut LoafOracle, arg2: u8, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceType<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<PriceType<T0>, 0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::SingleOracle<T0>>(&mut arg1.id, v0, 0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::new<T0>(arg2, arg3, arg4, arg5));
    }

    public fun get_price<T0>(arg0: &LoafOracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(arg0.version == 1, 99);
        0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::get_price<T0>(borrow_single_oracle<T0>(arg0), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_oracle(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        create_single_oracle<0x2::sui::SUI>(&v2, v4, 9, 3600000, 1, arg0);
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
        0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::remove_rule<T0, T1>(borrow_single_oracle_mut<T0>(arg1));
    }

    public entry fun update_package_version<T0>(arg0: &AdminCap, arg1: &mut LoafOracle, arg2: u64) {
        arg1.version = arg2;
    }

    public entry fun update_price<T0>(arg0: &AdminCap, arg1: &mut LoafOracle, arg2: &0x2::clock::Clock, arg3: u64) {
        assert!(arg1.version == 1, 99);
        0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::update_price<T0>(borrow_single_oracle_mut<T0>(arg1), arg2, arg3);
    }

    public entry fun update_threshold<T0>(arg0: &AdminCap, arg1: &mut LoafOracle, arg2: u64) {
        0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle::update_threshold<T0>(borrow_single_oracle_mut<T0>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

