module 0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        allowed_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        max_price_delta_pips: u64,
        max_output_delta_pips: u64,
    }

    fun type_name<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    public fun assert_output(arg0: &Registry, arg1: u64, arg2: u64) {
        let v0 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        assert!(0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::safe_math::mul_div_u64(v0, 0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::constants::scaling_pips(), arg1) <= arg0.max_output_delta_pips, 4);
    }

    public fun assert_price(arg0: &Registry, arg1: u128, arg2: u128) {
        let v0 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        assert!((0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::safe_math::mul_div_u128(v0, 0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::constants::scaling_pips_u128(), arg1) as u64) <= arg0.max_price_delta_pips, 3);
    }

    public(friend) fun assert_witness<T0>(arg0: &Registry) {
        assert!(arg0.version <= 0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::constants::current_version(), 0);
        let v0 = type_name<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_witnesses, &v0), 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id                    : 0x2::object::new(arg0),
            version               : 0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::constants::current_version(),
            allowed_witnesses     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            max_price_delta_pips  : 25000,
            max_output_delta_pips : 500,
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun insert_witness<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_witnesses, type_name<T0>());
    }

    public fun remove_witness<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        let v0 = type_name<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_witnesses, &v0);
    }

    public fun update_max_output_delta_pips(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 < 0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::constants::scaling_pips(), 2);
        arg0.max_output_delta_pips = arg1;
    }

    public fun update_max_price_delta_pips(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 < 0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::constants::scaling_pips(), 2);
        arg0.max_price_delta_pips = arg1;
    }

    public fun update_version(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

