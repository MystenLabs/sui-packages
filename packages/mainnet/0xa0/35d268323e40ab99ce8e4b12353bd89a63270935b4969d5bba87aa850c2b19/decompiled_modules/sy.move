module 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::sy {
    struct SY has drop {
        dummy_field: bool,
    }

    struct SY_TYPE_REG has drop {
        dummy_field: bool,
    }

    struct SY_UNDERLYING_TYPE_REG has drop {
        dummy_field: bool,
    }

    struct DepositEvent<phantom T0: drop> has copy, drop {
        amount_in: u64,
        share_out: u64,
    }

    struct RedeemEvent<phantom T0: drop> has copy, drop {
        share_in: u64,
        amount_out: u64,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        type_table: 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::WitTable<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>,
        underlying_type_table: 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::WitTable<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>,
        balance_bag: 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::BalanceBag,
    }

    struct FlashLoan<phantom T0: drop> {
        amount: u64,
    }

    public fun borrow<T0: drop>(arg0: u64, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan<T0>) {
        let v0 = FlashLoan<T0>{amount: arg0};
        (mint<T0>(arg0, arg1, arg2), v0)
    }

    public(friend) fun burn<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: &mut State) : u64 {
        0x2::coin::burn<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, 0x1::type_name::get<T0>()), arg0)
    }

    public(friend) fun mint<T0: drop>(arg0: u64, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, 0x1::type_name::get<T0>()), arg0, arg2)
    }

    public(friend) fun asset_to_sy(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::divDown(arg1, arg0)
    }

    public(friend) fun asset_to_sy_up(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::divDown(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::sub(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::add(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(arg1, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::one()), arg0), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(1)), arg0)
    }

    public fun deposit<T0: drop, T1: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::assert_current_version(arg0);
        assert!(is_sy_bind<T0, T1>(arg2), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::sy_not_supported());
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::sy_zero_deposit());
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::join<T0>(&mut arg2.balance_bag, v0);
        let v2 = DepositEvent<T0>{
            amount_in : v1,
            share_out : v1,
        };
        0x2::event::emit<DepositEvent<T0>>(v2);
        mint<T1>(v1, arg2, arg3)
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SY_TYPE_REG{dummy_field: false};
        let v1 = SY_UNDERLYING_TYPE_REG{dummy_field: false};
        let v2 = State{
            id                    : 0x2::object::new(arg1),
            type_table            : 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::new<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, true, arg1),
            underlying_type_table : 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::new<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v1, true, arg1),
            balance_bag           : 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::new(arg1),
        };
        0x2::transfer::share_object<State>(v2);
    }

    public fun is_sy_bind<T0: drop, T1: drop>(arg0: &State) : bool {
        if (0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::contains<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.type_table, 0x1::type_name::get<T1>())) {
            let v1 = 0x1::type_name::get<T0>();
            0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::borrow<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.type_table, 0x1::type_name::get<T1>()) == &v1
        } else {
            false
        }
    }

    public fun is_sy_bind_with_underlying_token<T0: drop, T1: drop>(arg0: &State) : bool {
        if (0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::contains<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.underlying_type_table, 0x1::type_name::get<T1>())) {
            let v1 = 0x1::type_name::get<T0>();
            0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::borrow<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.underlying_type_table, 0x1::type_name::get<T1>()) == &v1
        } else {
            false
        }
    }

    public fun is_sy_registered<T0: drop>(arg0: &State) : bool {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::contains<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.type_table, 0x1::type_name::get<T0>())
    }

    public fun redeem<T0: drop, T1: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::Version, arg1: 0x2::coin::Coin<T1>, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::assert_current_version(arg0);
        assert!(is_sy_bind<T0, T1>(arg2), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::sy_not_supported());
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = RedeemEvent<T1>{
            share_in   : v0,
            amount_out : v0,
        };
        0x2::event::emit<RedeemEvent<T1>>(v1);
        burn<T1>(arg1, arg2);
        0x2::coin::from_balance<T0>(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::split<T0>(&mut arg2.balance_bag, v0), arg3)
    }

    fun register_sy<T0: drop, T1: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg1: &mut State, arg2: &0x2::tx_context::TxContext) {
        assert!(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::has_role(arg0, 0x2::tx_context::sender(arg2), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::admin_role()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::register_sy_invalid_sender());
        assert!(!0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::contains<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg1.type_table, 0x1::type_name::get<T1>()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::register_sy_type_already_registered());
        let v0 = SY_TYPE_REG{dummy_field: false};
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::add<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, &mut arg1.type_table, 0x1::type_name::get<T1>(), 0x1::type_name::get<T0>());
    }

    public fun register_sy_with_underlying_token<T0: drop, T1: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::Version, arg1: &mut 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::assert_current_version(arg0);
        register_underlying_token<T0, T1>(arg1, arg2, arg3);
    }

    public fun register_sy_with_yield_token<T0: drop, T1: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::Version, arg1: &mut 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg2: 0x2::coin::TreasuryCap<T1>, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::assert_current_version(arg0);
        register_sy<T0, T1>(arg1, arg3, arg4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg3.id, 0x1::type_name::get<T1>(), arg2);
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::init_balance<T0>(&mut arg3.balance_bag);
    }

    fun register_underlying_token<T0: drop, T1: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg1: &mut State, arg2: &0x2::tx_context::TxContext) {
        assert!(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::has_role(arg0, 0x2::tx_context::sender(arg2), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::admin_role()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::register_sy_invalid_sender());
        assert!(!0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::contains<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg1.underlying_type_table, 0x1::type_name::get<T1>()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::register_sy_type_already_registered());
        let v0 = SY_UNDERLYING_TYPE_REG{dummy_field: false};
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::add<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, &mut arg1.underlying_type_table, 0x1::type_name::get<T1>(), 0x1::type_name::get<T0>());
    }

    public fun remove_sy_binding<T0: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg1: &mut State, arg2: &0x2::tx_context::TxContext) {
        assert!(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::has_role(arg0, 0x2::tx_context::sender(arg2), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::admin_role()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::register_sy_invalid_sender());
        let v0 = SY_TYPE_REG{dummy_field: false};
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table::remove<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, &mut arg1.type_table, 0x1::type_name::get<T0>());
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SY>>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<SY>>(&mut arg1.id, 0x1::type_name::get<T0>()), 0x2::tx_context::sender(arg2));
    }

    public fun repay<T0: drop>(arg0: FlashLoan<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut State) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.amount, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::sy_insufficient_repay());
        burn<T0>(arg1, arg2);
        let FlashLoan {  } = arg0;
    }

    public(friend) fun sy_to_asset(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(arg0, arg1)
    }

    public(friend) fun sy_to_asset_up(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::divDown(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::sub(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::add(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(arg0, arg1), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::one()), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(1)), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::one())
    }

    public(friend) fun uid(arg0: &mut State) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

