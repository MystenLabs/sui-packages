module 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct Metadata has store, key {
        id: 0x2::object::UID,
        deposit_cap: u64,
        balance: u64,
        whitelisted_app_id: 0x2::object::ID,
        priority: u64,
        min_fee_bps: u64,
        max_fee_bps: u64,
        decimals: u8,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
        meta_coin_decimals: u8,
        metadata: 0x2::object_table::ObjectTable<0x1::type_name::TypeName, Metadata>,
        total_priorities: u64,
        funds: 0x2::object_bag::ObjectBag,
        fees: 0x2::object_bag::ObjectBag,
    }

    struct DepositCap<phantom T0> {
        exchange_rate_coin_in_to_meta_coin: u64,
    }

    struct WithdrawCap<phantom T0> {
        exchange_rate_meta_coin_to_coin_out: u64,
    }

    public fun borrow<T0>(arg0: &Vault<T0>, arg1: 0x1::type_name::TypeName) : &Metadata {
        0x2::object_table::borrow<0x1::type_name::TypeName, Metadata>(&arg0.metadata, arg1)
    }

    fun borrow_mut<T0>(arg0: &mut Vault<T0>, arg1: 0x1::type_name::TypeName) : &mut Metadata {
        0x2::object_table::borrow_mut<0x1::type_name::TypeName, Metadata>(&mut arg0.metadata, arg1)
    }

    public fun swap<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::Version, arg2: DepositCap<T1>, arg3: WithdrawCap<T2>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::assert_correct_package(arg1);
        let DepositCap { exchange_rate_coin_in_to_meta_coin: v0 } = arg2;
        let v1 = 0x2::coin::value<T1>(&arg4);
        join<T0, T1>(arg0, arg4);
        let WithdrawCap { exchange_rate_meta_coin_to_coin_out: v2 } = arg3;
        let v3 = 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::normalize_decimals(0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::multiply_by_exchange_rate(0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::multiply_by_exchange_rate(v1, v0), v2), decimals_of<T0, T1>(arg0), decimals_of<T0, T2>(arg0));
        let v4 = split<T0, T2>(arg0, v3, arg5);
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::events::emit_swap_event<T1, T2>(0x2::object::uid_to_inner(&arg0.id), v1, v3);
        v4
    }

    public fun balance(arg0: &Metadata) : u64 {
        arg0.balance
    }

    fun join<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 != 0, 9223375043332538379);
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::object_table::contains<0x1::type_name::TypeName, Metadata>(&arg0.metadata, v1), 9223375064806850563);
        let v2 = borrow_mut<T0>(arg0, v1);
        let v3 = v2.balance + v0;
        assert!(v3 <= v2.deposit_cap, 9223375094871752709);
        v2.balance = v3;
        0x2::coin::join<T1>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.funds, v1), arg1);
    }

    fun split<T0, T1>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.funds, v0);
        assert!(arg1 <= 0x2::coin::value<T1>(v1), 9223375249490706439);
        let v2 = 0x2::coin::split<T1>(v1, arg1, arg2);
        let v3 = &mut v2;
        take_fee<T0, T1>(arg0, v3, arg2);
        let v4 = borrow_mut<T0>(arg0, v0);
        v4.balance = v4.balance - 0x2::coin::value<T1>(&v2);
        v2
    }

    public fun add_support_for_new_coin<T0, T1>(arg0: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::AdminCap, arg1: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::Version, arg2: &mut Vault<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::coin::CoinMetadata<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        add_support_for_new_coin_unsafe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::get_decimals<T1>(arg8), arg9);
    }

    public fun add_support_for_new_coin_unsafe<T0, T1>(arg0: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::AdminCap, arg1: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::Version, arg2: &mut Vault<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::object_table::contains<0x1::type_name::TypeName, Metadata>(&arg2.metadata, v0), 9223374137094307849);
        let v1 = Metadata{
            id                 : 0x2::object::new(arg9),
            deposit_cap        : arg4,
            balance            : 0,
            whitelisted_app_id : 0x2::object::id_from_address(arg3),
            priority           : arg7,
            min_fee_bps        : arg5,
            max_fee_bps        : arg6,
            decimals           : arg8,
        };
        0x2::object_table::add<0x1::type_name::TypeName, Metadata>(&mut arg2.metadata, v0, v1);
        arg2.total_priorities = arg2.total_priorities + arg7;
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.funds, v0, 0x2::coin::zero<T1>(arg9));
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.fees, v0, 0x2::coin::zero<T1>(arg9));
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::events::emit_support_coin_event<T1>(0x2::object::uid_to_inner(&arg2.id), arg4, arg5, arg6, arg7, arg8);
    }

    fun burn<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::decrease_supply<T0>(&mut arg0.supply, 0x2::coin::into_balance<T0>(arg1));
    }

    fun calculate_dynamic_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg1 >= arg2) {
            arg4
        } else {
            arg3 - 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::multiply_and_divide(((arg3 - arg4) as u128), (arg2 as u128), (arg1 as u128))
        };
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::multiply_and_divide((arg0 as u128), (v0 as u128), 10000)
    }

    public fun create_deposit_cap<T0, T1>(arg0: &0x2::object::UID, arg1: &Vault<T0>, arg2: u64) : DepositCap<T1> {
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::assert_app_is_authorized(arg0);
        assert!(0x2::object::uid_to_inner(arg0) == borrow<T0>(arg1, 0x1::type_name::get<T1>()).whitelisted_app_id, 9223374626720841741);
        DepositCap<T1>{exchange_rate_coin_in_to_meta_coin: arg2}
    }

    public fun create_vault<T0>(arg0: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::AdminCap, arg1: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::Version, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::assert_correct_package(arg1);
        let v0 = 0x2::coin::treasury_into_supply<T0>(arg2);
        assert!(0x2::balance::supply_value<T0>(&v0) == 0, 9223372947387842561);
        let v1 = Vault<T0>{
            id                 : 0x2::object::new(arg4),
            supply             : v0,
            meta_coin_decimals : 0x2::coin::get_decimals<T0>(arg3),
            metadata           : 0x2::object_table::new<0x1::type_name::TypeName, Metadata>(arg4),
            total_priorities   : 0,
            funds              : 0x2::object_bag::new(arg4),
            fees               : 0x2::object_bag::new(arg4),
        };
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::events::emit_create_vault_event<T0>(0x2::object::uid_to_inner(&v1.id), v1.meta_coin_decimals);
        0x2::transfer::share_object<Vault<T0>>(v1);
    }

    public fun create_withdraw_cap<T0, T1>(arg0: &0x2::object::UID, arg1: &Vault<T0>, arg2: u64) : WithdrawCap<T1> {
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::assert_app_is_authorized(arg0);
        assert!(0x2::object::uid_to_inner(arg0) == borrow<T0>(arg1, 0x1::type_name::get<T1>()).whitelisted_app_id, 9223374819994501135);
        WithdrawCap<T1>{exchange_rate_meta_coin_to_coin_out: arg2}
    }

    public fun decimals(arg0: &Metadata) : u8 {
        arg0.decimals
    }

    public fun decimals_of<T0, T1>(arg0: &Vault<T0>) : u8 {
        borrow<T0>(arg0, 0x1::type_name::get<T1>()).decimals
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::Version, arg2: DepositCap<T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::assert_correct_package(arg1);
        let DepositCap { exchange_rate_coin_in_to_meta_coin: v0 } = arg2;
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::multiply_by_exchange_rate(0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::normalize_decimals(v1, decimals_of<T0, T1>(arg0), arg0.meta_coin_decimals), v0);
        join<T0, T1>(arg0, arg3);
        let v3 = mint<T0>(arg0, v2, arg4);
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::events::emit_deposit_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v1, v2);
        v3
    }

    public fun deposit_cap(arg0: &Metadata) : u64 {
        arg0.deposit_cap
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::AdminCap>(0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::create_admin_cap<VAULT>(&arg0, arg1), v0);
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::create_version<VAULT>(&arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<VAULT>(arg0, arg1), v0);
    }

    fun join_fee<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::join<T1>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.fees, 0x1::type_name::get<T1>()), arg1);
    }

    public fun max_fee_bps(arg0: &Metadata) : u64 {
        arg0.max_fee_bps
    }

    public fun min_fee_bps(arg0: &Metadata) : u64 {
        arg0.min_fee_bps
    }

    fun mint<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.supply, arg1), arg2)
    }

    public fun priority(arg0: &Metadata) : u64 {
        arg0.priority
    }

    fun take_fee<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow<T0>(arg0, 0x1::type_name::get<T1>());
        let v1 = 0x2::coin::value<T1>(arg1);
        let v2 = 0x2::coin::split<T1>(arg1, calculate_dynamic_fee(v1, 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::normalize_decimals(0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::multiply_and_divide((0x2::balance::supply_value<T0>(&arg0.supply) as u128), (v0.priority as u128), (arg0.total_priorities as u128)), arg0.meta_coin_decimals, v0.decimals), v0.balance - v1, v0.max_fee_bps, v0.min_fee_bps), arg2);
        join_fee<T0, T1>(arg0, v2);
    }

    public fun whitelisted_app_id(arg0: &Metadata) : 0x2::object::ID {
        arg0.whitelisted_app_id
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::Version, arg2: WithdrawCap<T1>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::assert_correct_package(arg1);
        let WithdrawCap { exchange_rate_meta_coin_to_coin_out: v0 } = arg2;
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::normalize_decimals(0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::multiply_by_exchange_rate(v1, v0), arg0.meta_coin_decimals, decimals_of<T0, T1>(arg0));
        let v3 = split<T0, T1>(arg0, v2, arg4);
        burn<T0>(arg0, arg3);
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::events::emit_withdraw_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v2, v1);
        v3
    }

    public fun withdraw_fees<T0, T1>(arg0: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::AdminCap, arg1: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::Version, arg2: &mut Vault<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_table::contains<0x1::type_name::TypeName, Metadata>(&arg2.metadata, v0), 9223374407676854275);
        let v1 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.fees, v0);
        0x2::coin::split<T1>(v1, 0x2::coin::value<T1>(v1), arg3)
    }

    // decompiled from Move bytecode v6
}

