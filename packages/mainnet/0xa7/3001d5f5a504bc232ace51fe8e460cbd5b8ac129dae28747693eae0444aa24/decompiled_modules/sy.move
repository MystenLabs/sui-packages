module 0xa73001d5f5a504bc232ace51fe8e460cbd5b8ac129dae28747693eae0444aa24::sy {
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
        type_table: 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::WitTable<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>,
        underlying_type_table: 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::WitTable<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>,
        balance_bag: 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::balance_bag::BalanceBag,
    }

    struct FlashLoan<phantom T0: drop> has store {
        amount: u64,
    }

    public(friend) fun borrow<T0: drop>(arg0: u64, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan<T0>) {
        let v0 = FlashLoan<T0>{amount: arg0};
        (mint<T0>(arg0, arg1, arg2), v0)
    }

    public(friend) fun burn<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::coin::burn<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, 0x1::type_name::get<T0>()), arg0)
    }

    public(friend) fun mint<T0: drop>(arg0: u64, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, 0x1::type_name::get<T0>()), arg0, arg2)
    }

    public(friend) fun asset_to_sy(arg0: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64 {
        0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::divDown(arg1, arg0)
    }

    public(friend) fun asset_to_sy_up(arg0: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64 {
        0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::divDown(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::sub(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::add(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::multiply(arg1, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::one()), arg0), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(1)), arg0)
    }

    public fun deposit<T0: drop, T1: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        assert!(is_sy_bind<T0, T1>(arg3), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::sy_not_supported());
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::sy_zero_deposit());
        assert!(v1 >= arg2, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::sy_insufficient_sharesOut());
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::balance_bag::join<T0>(&mut arg3.balance_bag, v0);
        let v2 = DepositEvent<T0>{
            amount_in : v1,
            share_out : v1,
        };
        0x2::event::emit<DepositEvent<T0>>(v2);
        mint<T1>(v1, arg3, arg4)
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SY_TYPE_REG{dummy_field: false};
        let v1 = SY_UNDERLYING_TYPE_REG{dummy_field: false};
        let v2 = State{
            id                    : 0x2::object::new(arg1),
            type_table            : 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::new<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, true, arg1),
            underlying_type_table : 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::new<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v1, true, arg1),
            balance_bag           : 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::balance_bag::new(arg1),
        };
        0x2::transfer::share_object<State>(v2);
    }

    public fun is_sy_bind<T0: drop, T1: drop>(arg0: &State) : bool {
        if (0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::contains<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.type_table, 0x1::type_name::get<T1>())) {
            let v1 = 0x1::type_name::get<T0>();
            0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::borrow<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.type_table, 0x1::type_name::get<T1>()) == &v1
        } else {
            false
        }
    }

    public fun is_sy_bind_with_underlying_token<T0: drop, T1: drop>(arg0: &State) : bool {
        if (0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::contains<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.underlying_type_table, 0x1::type_name::get<T1>())) {
            let v1 = 0x1::type_name::get<T0>();
            0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::borrow<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.underlying_type_table, 0x1::type_name::get<T1>()) == &v1
        } else {
            false
        }
    }

    public fun is_sy_registered<T0: drop>(arg0: &State) : bool {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::contains<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.type_table, 0x1::type_name::get<T0>())
    }

    public fun redeem<T0: drop, T1: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        assert!(is_sy_bind<T0, T1>(arg3), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::sy_not_supported());
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::sy_zero_redeem());
        assert!(v0 >= arg2, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::sy_insufficient_amountOut());
        let v1 = RedeemEvent<T1>{
            share_in   : v0,
            amount_out : v0,
        };
        0x2::event::emit<RedeemEvent<T1>>(v1);
        burn<T1>(arg1, arg3, arg4);
        0x2::coin::from_balance<T0>(0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::balance_bag::split<T0>(&mut arg3.balance_bag, v0), arg4)
    }

    fun register_sy<T0: drop, T1: drop>(arg0: &mut 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::ACL, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::has_role(arg0, 0x2::tx_context::sender(arg2), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::register_sy_role()), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::register_sy_invalid_sender());
        assert!(!0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::contains<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg1.type_table, 0x1::type_name::get<T1>()), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::register_sy_type_already_registered());
        let v0 = SY_TYPE_REG{dummy_field: false};
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::add<SY_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, &mut arg1.type_table, 0x1::type_name::get<T1>(), 0x1::type_name::get<T0>());
    }

    public fun register_sy_with_underlying_token<T0: drop, T1: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: &mut 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::ACL, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        register_underlying_token<T0, T1>(arg1, arg2, arg3);
    }

    public fun register_sy_with_yield_token<T0: drop, T1: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: &mut 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::ACL, arg2: 0x2::coin::TreasuryCap<T1>, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        register_sy<T0, T1>(arg1, arg3, arg4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg3.id, 0x1::type_name::get<T1>(), arg2);
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::balance_bag::init_balance<T0>(&mut arg3.balance_bag);
    }

    fun register_underlying_token<T0: drop, T1: drop>(arg0: &mut 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::ACL, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::has_role(arg0, 0x2::tx_context::sender(arg2), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::register_sy_role()), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::register_sy_invalid_sender());
        assert!(!0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::contains<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg1.underlying_type_table, 0x1::type_name::get<T1>()), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::register_sy_type_already_registered());
        let v0 = SY_UNDERLYING_TYPE_REG{dummy_field: false};
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::wit_table::add<SY_UNDERLYING_TYPE_REG, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, &mut arg1.underlying_type_table, 0x1::type_name::get<T1>(), 0x1::type_name::get<T0>());
    }

    public(friend) fun repay<T0: drop>(arg0: FlashLoan<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.amount, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::sy_insufficient_repay());
        burn<T0>(arg1, arg2, arg3);
        let FlashLoan {  } = arg0;
    }

    public(friend) fun sy_to_asset(arg0: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64 {
        0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::multiply(arg0, arg1)
    }

    public(friend) fun sy_to_asset_up(arg0: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64 {
        0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::divDown(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::sub(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::add(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::multiply(arg0, arg1), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::one()), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(1)), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::one())
    }

    public fun uid(arg0: &mut State) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

