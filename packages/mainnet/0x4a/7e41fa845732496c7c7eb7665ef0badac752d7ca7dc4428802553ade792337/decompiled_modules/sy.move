module 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy {
    struct SY has drop {
        dummy_field: bool,
    }

    struct SY_TYPE_REG has drop {
        dummy_field: bool,
    }

    struct SY_DECIMAL_REGISTRY has drop {
        dummy_field: bool,
    }

    struct DepositEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        amount_in: u64,
        share_out: u64,
    }

    struct RedeemEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        share_in: u64,
        amount_out: u64,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        type_table: 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::WitTable<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>,
        decimal_table: 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::WitTable<SY_DECIMAL_REGISTRY, 0x1::type_name::TypeName, u8>,
        balance_bag: 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::BalanceBag,
    }

    struct FlashLoan<phantom T0: drop> {
        amount: u64,
    }

    public(friend) fun borrow<T0: drop>(arg0: u64, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan<T0>) {
        let v0 = FlashLoan<T0>{amount: arg0};
        (mint<T0>(arg0, arg1, arg2), v0)
    }

    public(friend) fun burn<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: &mut State) : u64 {
        0x2::coin::burn<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, 0x1::type_name::get<T0>()), arg0)
    }

    public(friend) fun mint<T0: drop>(arg0: u64, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, 0x1::type_name::get<T0>()), arg0, arg2)
    }

    public(friend) fun asset_to_sy(arg0: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, arg1: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::divDown(arg1, arg0)
    }

    public(friend) fun asset_to_sy_up(arg0: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, arg1: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::divDown(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::sub(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::add(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::multiply(arg1, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::one()), arg0), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(1)), arg0)
    }

    public fun deposit<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: 0x2::coin::Coin<T1>, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(is_sy_bind<T0, T1>(arg2), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::sy_not_supported());
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::sy_zero_deposit());
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::join<T1>(&mut arg2.balance_bag, v0);
        let v2 = DepositEvent<T0, T1>{
            amount_in : v1,
            share_out : v1,
        };
        0x2::event::emit<DepositEvent<T0, T1>>(v2);
        mint<T0>(v1, arg2, arg3)
    }

    public(friend) fun get_decimal(arg0: &State, arg1: 0x1::type_name::TypeName) : u8 {
        *0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::borrow<SY_DECIMAL_REGISTRY, 0x1::type_name::TypeName, u8>(&arg0.decimal_table, arg1)
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SY_TYPE_REG{dummy_field: false};
        let v1 = SY_DECIMAL_REGISTRY{dummy_field: false};
        let v2 = State{
            id            : 0x2::object::new(arg1),
            type_table    : 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::new<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, true, arg1),
            decimal_table : 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::new<SY_DECIMAL_REGISTRY, 0x1::type_name::TypeName, u8>(v1, true, arg1),
            balance_bag   : 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::new(arg1),
        };
        0x2::transfer::share_object<State>(v2);
    }

    public fun is_sy_bind<T0: drop, T1: drop>(arg0: &State) : bool {
        if (0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::contains<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.type_table, 0x1::type_name::with_defining_ids<T0>())) {
            let v1 = 0x1::type_name::with_defining_ids<T1>();
            0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::borrow<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.type_table, 0x1::type_name::with_defining_ids<T0>()) == &v1
        } else {
            false
        }
    }

    public fun is_sy_registered<T0: drop>(arg0: &State) : bool {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::contains<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.type_table, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun redeem<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(is_sy_bind<T0, T1>(arg2), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::sy_not_supported());
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = RedeemEvent<T0, T1>{
            share_in   : v0,
            amount_out : v0,
        };
        0x2::event::emit<RedeemEvent<T0, T1>>(v1);
        burn<T0>(arg1, arg2);
        0x2::coin::from_balance<T1>(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::split<T1>(&mut arg2.balance_bag, v0), arg3)
    }

    public fun register_sy_with_yield_token<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: 0x2::coin::TreasuryCap<T0>, arg3: u8, arg4: &mut State, arg5: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::register_sy_invalid_sender());
        assert!(!0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::contains<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg4.type_table, 0x1::type_name::get<T0>()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::register_sy_type_already_registered());
        assert!(arg3 >= 3 && arg3 <= 18, 0);
        let v0 = SY_TYPE_REG{dummy_field: false};
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::add<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, &mut arg4.type_table, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v1 = SY_DECIMAL_REGISTRY{dummy_field: false};
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::add<SY_DECIMAL_REGISTRY, 0x1::type_name::TypeName, u8>(v1, &mut arg4.decimal_table, 0x1::type_name::get<T0>(), arg3);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg4.id, 0x1::type_name::get<T0>(), arg2);
        if (!0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::contains<T1>(&arg4.balance_bag)) {
            0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::init_balance<T1>(&mut arg4.balance_bag);
        };
    }

    public fun remove_sy_binding<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut State, arg3: &0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg3), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::register_sy_invalid_sender());
        let v0 = SY_TYPE_REG{dummy_field: false};
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::remove<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, &mut arg2.type_table, 0x1::type_name::get<T0>());
        let v1 = SY_DECIMAL_REGISTRY{dummy_field: false};
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::remove<SY_DECIMAL_REGISTRY, 0x1::type_name::TypeName, u8>(v1, &mut arg2.decimal_table, 0x1::type_name::get<T0>());
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg2.id, 0x1::type_name::get<T0>())
    }

    public(friend) fun repay<T0: drop>(arg0: FlashLoan<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut State) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.amount, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::sy_insufficient_repay());
        burn<T0>(arg1, arg2);
        let FlashLoan {  } = arg0;
    }

    public(friend) fun sy_to_asset(arg0: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, arg1: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::multiply(arg0, arg1)
    }

    public(friend) fun sy_to_asset_up(arg0: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, arg1: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::divDown(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::sub(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::add(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::multiply(arg0, arg1), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::one()), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(1)), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::one())
    }

    public(friend) fun uid(arg0: &mut State) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

