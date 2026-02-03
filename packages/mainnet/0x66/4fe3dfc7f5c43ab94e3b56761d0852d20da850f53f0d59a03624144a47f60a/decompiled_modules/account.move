module 0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::account {
    struct AccountCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        account_obj_id: 0x2::object::ID,
        account_id: u64,
    }

    struct Account<phantom T0> has store, key {
        id: 0x2::object::UID,
        account_id: u64,
        collateral: 0x2::balance::Balance<T0>,
    }

    struct AccountSharePolicy {
        pos0: 0x2::object::ID,
    }

    struct IntegratorConfig has store {
        max_taker_fee: u256,
    }

    public(friend) fun add_integrator_config<T0>(arg0: &AccountCap<T0>, arg1: &mut Account<T0>, arg2: address, arg3: u256) {
        check_valid_account_cap<T0>(arg1, arg0);
        let v0 = IntegratorConfig{max_taker_fee: arg3};
        0x2::dynamic_field::add<0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::keys::IntegratorConfig, IntegratorConfig>(&mut arg1.id, 0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::keys::integrator_config(arg2), v0);
        0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::events::emit_added_integrator_config<T0>(arg1.account_id, arg2, arg3);
    }

    public fun check_valid_account_cap<T0>(arg0: &Account<T0>, arg1: &AccountCap<T0>) {
        assert!(arg0.account_id == arg1.account_id, 0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::errors::invalid_account_cap());
    }

    public(friend) fun consume_policy_and_share_account<T0>(arg0: Account<T0>, arg1: AccountSharePolicy) {
        let AccountSharePolicy { pos0: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::errors::invalid_share_policy());
        0x2::transfer::share_object<Account<T0>>(arg0);
    }

    public(friend) fun create_account<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : (Account<T0>, AccountSharePolicy, AccountCap<T0>) {
        let v0 = Account<T0>{
            id         : 0x2::object::new(arg1),
            account_id : arg0,
            collateral : 0x2::balance::zero<T0>(),
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        let v2 = AccountSharePolicy{pos0: v1};
        let v3 = AccountCap<T0>{
            id             : 0x2::object::new(arg1),
            account_obj_id : v1,
            account_id     : arg0,
        };
        0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::events::emit_created_account<T0>(v1, 0x2::tx_context::sender(arg1), arg0);
        (v0, v2, v3)
    }

    public(friend) fun deposit_collateral<T0>(arg0: &AccountCap<T0>, arg1: &mut Account<T0>, arg2: 0x2::coin::Coin<T0>) {
        check_valid_account_cap<T0>(arg1, arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 != 0, 0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::errors::deposit_or_withdraw_amount_zero());
        0x2::balance::join<T0>(&mut arg1.collateral, 0x2::coin::into_balance<T0>(arg2));
        0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::events::emit_deposited_collateral<T0>(arg1.account_id, v0);
    }

    public fun get_account_id<T0>(arg0: &Account<T0>) : u64 {
        arg0.account_id
    }

    public fun get_cap_account_id<T0>(arg0: &AccountCap<T0>) : u64 {
        arg0.account_id
    }

    public fun get_cap_account_obj_id<T0>(arg0: &AccountCap<T0>) : 0x2::object::ID {
        arg0.account_obj_id
    }

    public(friend) fun get_collateral_mut<T0>(arg0: &mut Account<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.collateral
    }

    public fun get_collateral_value<T0>(arg0: &Account<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun get_integrator_config<T0>(arg0: &Account<T0>, arg1: address) : &IntegratorConfig {
        0x2::dynamic_field::borrow<0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::keys::IntegratorConfig, IntegratorConfig>(&arg0.id, 0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::keys::integrator_config(arg1))
    }

    public fun get_integrator_max_taker_fee(arg0: &IntegratorConfig) : u256 {
        arg0.max_taker_fee
    }

    public(friend) fun remove_integrator_config<T0>(arg0: &AccountCap<T0>, arg1: &mut Account<T0>, arg2: address) {
        check_valid_account_cap<T0>(arg1, arg0);
        let IntegratorConfig {  } = 0x2::dynamic_field::remove<0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::keys::IntegratorConfig, IntegratorConfig>(&mut arg1.id, 0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::keys::integrator_config(arg2));
        0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::events::emit_removed_integrator_config<T0>(arg1.account_id, arg2);
    }

    public(friend) fun withdraw_collateral<T0>(arg0: &AccountCap<T0>, arg1: &mut Account<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_valid_account_cap<T0>(arg1, arg0);
        assert!(arg2 != 0, 0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::errors::deposit_or_withdraw_amount_zero());
        0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::events::emit_withdrew_collateral<T0>(arg1.account_id, arg2);
        0x2::coin::take<T0>(&mut arg1.collateral, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

