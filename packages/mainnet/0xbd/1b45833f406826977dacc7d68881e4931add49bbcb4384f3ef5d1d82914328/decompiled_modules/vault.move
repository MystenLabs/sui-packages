module 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        assets: 0x2::bag::Bag,
        policy: 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::Policy,
        strategy_id: vector<u8>,
        adapter_version: u64,
        version: u64,
        last_action_ms: u64,
        hwm_e6: u64,
        paused: bool,
        closed: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct PricedLoan {
        vault: 0x2::object::ID,
        type_a: 0x1::type_name::TypeName,
        type_b: 0x1::type_name::TypeName,
        dec_a: u8,
        dec_b: u8,
        value_before_e6: u64,
        max_loss_e6: u64,
        borrowed_total_e6: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        strategy_id: vector<u8>,
    }

    struct VaultClosed has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct ObjectWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        name: vector<u8>,
    }

    struct SettledPriced has copy, drop {
        vault_id: 0x2::object::ID,
        value_before_e6: u64,
        value_after_e6: u64,
        max_loss_e6: u64,
        ts_ms: u64,
    }

    struct PolicyUpdated has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct StrategyUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: vector<u8>,
    }

    struct HwmUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        hwm_e6: u64,
    }

    public fun policy(arg0: &Vault) : &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::Policy {
        &arg0.policy
    }

    public fun set_limits(arg0: &OwnerCap, arg1: &mut Vault, arg2: u16, arg3: u64, arg4: u64) {
        assert_owner(arg0, arg1);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::set_limits(&mut arg1.policy, arg2, arg3, arg4);
        let v0 = PolicyUpdated{vault_id: 0x2::object::id<Vault>(arg1)};
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun adapter_version(arg0: &Vault) : u64 {
        arg0.adapter_version
    }

    fun assert_owner(arg0: &OwnerCap, arg1: &Vault) {
        assert!(arg0.vault == 0x2::object::id<Vault>(arg1), 1);
    }

    fun assert_position_ok(arg0: &Vault, arg1: u64) {
        if (0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::max_position_usd_e6(&arg0.policy) > 0) {
            0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::assert_position_size(&arg0.policy, arg1);
        };
    }

    public fun balance_value<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.assets, v0))
        } else {
            0
        }
    }

    public fun borrow_priced<T0>(arg0: &mut Vault, arg1: u64, arg2: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::Price, arg3: u8, arg4: &0x2::clock::Clock, arg5: PricedLoan) : (0x2::balance::Balance<T0>, PricedLoan) {
        assert!(arg5.vault == 0x2::object::id<Vault>(arg0), 3);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::assert_token<T0>(&arg0.policy);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::assert_fresh(arg2, arg4, 60000);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == arg5.type_a || v0 == arg5.type_b, 8);
        let v1 = if (v0 == arg5.type_a) {
            arg5.dec_a
        } else {
            arg5.dec_b
        };
        assert!(arg3 == v1, 9);
        let v2 = 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::quote_value_e6<T0>(arg2, arg1, arg3);
        let v3 = arg5.borrowed_total_e6 + v2;
        assert_position_ok(arg0, v3);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets, v4), 6);
        let v5 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets, v4);
        assert!(0x2::balance::value<T0>(&v5) >= arg1, 6);
        if (0x2::balance::value<T0>(&v5) > 0) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets, v4, v5);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        let PricedLoan {
            vault             : v6,
            type_a            : v7,
            type_b            : v8,
            dec_a             : v9,
            dec_b             : v10,
            value_before_e6   : v11,
            max_loss_e6       : v12,
            borrowed_total_e6 : _,
        } = arg5;
        let v14 = PricedLoan{
            vault             : v6,
            type_a            : v7,
            type_b            : v8,
            dec_a             : v9,
            dec_b             : v10,
            value_before_e6   : v11,
            max_loss_e6       : v12 + (((v2 as u128) * (0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::max_slippage_bps(&arg0.policy) as u128) / 10000) as u64),
            borrowed_total_e6 : v3,
        };
        (0x2::balance::split<T0>(&mut v5, arg1), v14)
    }

    public fun close(arg0: &OwnerCap, arg1: &mut Vault) {
        assert_owner(arg0, arg1);
        assert!(0x2::bag::is_empty(&arg1.assets), 5);
        arg1.closed = true;
        let v0 = VaultClosed{vault_id: 0x2::object::id<Vault>(arg1)};
        0x2::event::emit<VaultClosed>(v0);
    }

    public fun create_lp_vault<T0, T1>(arg0: vector<address>, arg1: u16, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T1>());
        let v1 = 0x2::vec_set::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0)) {
            0x2::vec_set::insert<address>(&mut v1, *0x1::vector::borrow<address>(&arg0, v2));
            v2 = v2 + 1;
        };
        let v3 = new_vault(0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::new(v0, v1, arg1, arg2, arg3, 0), arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<OwnerCap>(v3, 0x2::tx_context::sender(arg7));
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        assert!(arg0.version == 1, 0);
        join_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Deposited{
            vault_id  : 0x2::object::id<Vault>(arg0),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun has_object(arg0: &Vault, arg1: vector<u8>) : bool {
        0x2::bag::contains<vector<u8>>(&arg0.assets, arg1)
    }

    public fun hwm_e6(arg0: &Vault) : u64 {
        arg0.hwm_e6
    }

    public fun is_closed(arg0: &Vault) : bool {
        arg0.closed
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    fun join_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets, v0, arg1);
        };
    }

    public fun last_action_ms(arg0: &Vault) : u64 {
        arg0.last_action_ms
    }

    public fun migrate(arg0: &OwnerCap, arg1: &mut Vault) {
        assert_owner(arg0, arg1);
        arg1.version = 1;
    }

    public fun new_vault(arg0: 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::Policy, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : OwnerCap {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Vault{
            id              : 0x2::object::new(arg4),
            owner           : v0,
            assets          : 0x2::bag::new(arg4),
            policy          : arg0,
            strategy_id     : arg1,
            adapter_version : arg2,
            version         : 1,
            last_action_ms  : 0x2::clock::timestamp_ms(arg3),
            hwm_e6          : 0,
            paused          : false,
            closed          : false,
        };
        let v2 = 0x2::object::id<Vault>(&v1);
        let v3 = OwnerCap{
            id    : 0x2::object::new(arg4),
            vault : v2,
        };
        let v4 = VaultCreated{
            vault_id    : v2,
            owner       : v0,
            strategy_id : arg1,
        };
        0x2::event::emit<VaultCreated>(v4);
        0x2::transfer::share_object<Vault>(v1);
        v3
    }

    public fun owner(arg0: &Vault) : address {
        arg0.owner
    }

    public fun priced_loan_max_loss_e6(arg0: &PricedLoan) : u64 {
        arg0.max_loss_e6
    }

    public fun priced_loan_value_before_e6(arg0: &PricedLoan) : u64 {
        arg0.value_before_e6
    }

    public fun put_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: &PricedLoan) {
        assert!(arg2.vault == 0x2::object::id<Vault>(arg0), 3);
        join_balance<T0>(arg0, arg1);
    }

    public fun put_object<T0: store>(arg0: &mut Vault, arg1: vector<u8>, arg2: T0, arg3: &PricedLoan) {
        assert!(arg3.vault == 0x2::object::id<Vault>(arg0), 3);
        0x2::bag::add<vector<u8>, T0>(&mut arg0.assets, arg1, arg2);
    }

    public fun session_open<T0, T1, T2: drop>(arg0: T2, arg1: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::operator::OperatorHub, arg2: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::registry::AdapterRegistry, arg3: &mut Vault, arg4: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::Price, arg5: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::Price, arg6: u8, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : PricedLoan {
        assert!(arg3.version == 1, 0);
        assert!(!arg3.paused && !arg3.closed, 2);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::assert_not_paused(&arg3.policy);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::operator::assert_active_operator(arg1, arg9);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::registry::assert_approved<T2>(arg2);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::assert_interval(&arg3.policy, arg3.last_action_ms, arg8);
        arg3.last_action_ms = 0x2::clock::timestamp_ms(arg8);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::assert_fresh(arg4, arg8, 60000);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::assert_fresh(arg5, arg8, 60000);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v0 != v1, 7);
        PricedLoan{
            vault             : 0x2::object::id<Vault>(arg3),
            type_a            : v0,
            type_b            : v1,
            dec_a             : arg6,
            dec_b             : arg7,
            value_before_e6   : 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::quote_value_e6<T0>(arg4, balance_value<T0>(arg3), arg6) + 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::quote_value_e6<T1>(arg5, balance_value<T1>(arg3), arg7),
            max_loss_e6       : 0,
            borrowed_total_e6 : 0,
        }
    }

    public fun set_hwm(arg0: &mut Vault, arg1: u64, arg2: &PricedLoan) {
        assert!(arg2.vault == 0x2::object::id<Vault>(arg0), 3);
        arg0.hwm_e6 = arg1;
        let v0 = HwmUpdated{
            vault_id : 0x2::object::id<Vault>(arg0),
            hwm_e6   : arg1,
        };
        0x2::event::emit<HwmUpdated>(v0);
    }

    public fun set_paused(arg0: &OwnerCap, arg1: &mut Vault, arg2: bool) {
        assert_owner(arg0, arg1);
        arg1.paused = arg2;
    }

    public fun set_policy(arg0: &OwnerCap, arg1: &mut Vault, arg2: 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::Policy) {
        assert_owner(arg0, arg1);
        arg1.policy = arg2;
        let v0 = PolicyUpdated{vault_id: 0x2::object::id<Vault>(arg1)};
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun set_strategy(arg0: &OwnerCap, arg1: &mut Vault, arg2: vector<u8>) {
        assert_owner(arg0, arg1);
        arg1.strategy_id = arg2;
        let v0 = StrategyUpdated{
            vault_id    : 0x2::object::id<Vault>(arg1),
            strategy_id : arg2,
        };
        0x2::event::emit<StrategyUpdated>(v0);
    }

    public fun settle_close<T0, T1>(arg0: &mut Vault, arg1: PricedLoan, arg2: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::Price, arg3: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::Price, arg4: &0x2::clock::Clock) {
        let PricedLoan {
            vault             : v0,
            type_a            : v1,
            type_b            : v2,
            dec_a             : v3,
            dec_b             : v4,
            value_before_e6   : v5,
            max_loss_e6       : v6,
            borrowed_total_e6 : _,
        } = arg1;
        assert!(v0 == 0x2::object::id<Vault>(arg0), 3);
        assert!(0x1::type_name::with_defining_ids<T0>() == v1 && 0x1::type_name::with_defining_ids<T1>() == v2, 7);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::assert_fresh(arg2, arg4, 60000);
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::assert_fresh(arg3, arg4, 60000);
        let v8 = 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::quote_value_e6<T0>(arg2, balance_value<T0>(arg0), v3) + 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::quote_value_e6<T1>(arg3, balance_value<T1>(arg0), v4);
        let v9 = (((v5 as u128) * (0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::policy::max_slippage_bps(&arg0.policy) as u128) / 10000) as u64);
        let v10 = if (v6 < v9) {
            v6
        } else {
            v9
        };
        assert!(v8 + v10 >= v5, 4);
        arg0.last_action_ms = 0x2::clock::timestamp_ms(arg4);
        let v11 = SettledPriced{
            vault_id        : v0,
            value_before_e6 : v5,
            value_after_e6  : v8,
            max_loss_e6     : v6,
            ts_ms           : arg0.last_action_ms,
        };
        0x2::event::emit<SettledPriced>(v11);
    }

    public fun strategy_id(arg0: &Vault) : vector<u8> {
        arg0.strategy_id
    }

    public fun withdraw<T0>(arg0: &OwnerCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.vault == 0x2::object::id<Vault>(arg1), 1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.assets, v0), 6);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.assets, v0);
        assert!(0x2::balance::value<T0>(&v1) >= arg2, 6);
        if (0x2::balance::value<T0>(&v1) > 0) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.assets, v0, v1);
        } else {
            0x2::balance::destroy_zero<T0>(v1);
        };
        let v2 = Withdrawn{
            vault_id  : 0x2::object::id<Vault>(arg1),
            coin_type : 0x1::type_name::into_string(v0),
            amount    : arg2,
        };
        0x2::event::emit<Withdrawn>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, arg2), arg3)
    }

    public fun withdraw_object<T0: store>(arg0: &OwnerCap, arg1: &mut Vault, arg2: vector<u8>) : T0 {
        assert!(arg0.vault == 0x2::object::id<Vault>(arg1), 1);
        let v0 = ObjectWithdrawn{
            vault_id : 0x2::object::id<Vault>(arg1),
            name     : arg2,
        };
        0x2::event::emit<ObjectWithdrawn>(v0);
        0x2::bag::remove<vector<u8>, T0>(&mut arg1.assets, arg2)
    }

    // decompiled from Move bytecode v7
}

