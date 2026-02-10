module 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct ASSISTANT has drop {
        dummy_field: bool,
    }

    struct AccountCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        account_obj_id: 0x2::object::ID,
        account_id: u64,
    }

    struct Account<phantom T0> has store, key {
        id: 0x2::object::UID,
        account_id: u64,
        collateral: 0x2::balance::Balance<T0>,
        active_assistants: vector<0x2::object::ID>,
    }

    struct AccountSharePolicy {
        pos0: 0x2::object::ID,
    }

    struct IntegratorConfig has store {
        max_taker_fee: u256,
    }

    public(friend) fun add_integrator_config<T0>(arg0: &mut Account<T0>, arg1: address, arg2: u256) {
        let v0 = IntegratorConfig{max_taker_fee: arg2};
        0x2::dynamic_field::add<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::IntegratorConfig, IntegratorConfig>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::integrator_config(arg1), v0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_added_integrator_config<T0>(arg0.account_id, arg1, arg2);
    }

    public fun check_valid_account_cap<T0, T1>(arg0: &Account<T0>, arg1: &AccountCap<T1>) {
        assert!(has_authority<T0, T1>(arg1, arg0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_account_cap());
    }

    public(friend) fun consume_policy_and_share_account<T0>(arg0: Account<T0>, arg1: AccountSharePolicy) {
        let AccountSharePolicy { pos0: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_share_policy());
        0x2::transfer::share_object<Account<T0>>(arg0);
    }

    public(friend) fun create_account<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : (Account<T0>, AccountSharePolicy, AccountCap<ADMIN>) {
        let v0 = Account<T0>{
            id                : 0x2::object::new(arg1),
            account_id        : arg0,
            collateral        : 0x2::balance::zero<T0>(),
            active_assistants : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        let v2 = AccountSharePolicy{pos0: v1};
        let v3 = AccountCap<ADMIN>{
            id             : 0x2::object::new(arg1),
            account_obj_id : v1,
            account_id     : arg0,
        };
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_created_account<T0>(v1, 0x2::tx_context::sender(arg1), arg0);
        (v0, v2, v3)
    }

    public(friend) fun deposit_collateral<T0>(arg0: &mut Account<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::deposit_or_withdraw_amount_zero());
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg1));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_deposited_collateral<T0>(arg0.account_id, v0);
    }

    public(friend) fun destroy_assistant_account_cap<T0>(arg0: AccountCap<ASSISTANT>, arg1: &mut Account<T0>) {
        revoke_assistant_account_cap<T0>(arg1, 0x2::object::uid_to_inner(&arg0.id));
        let AccountCap {
            id             : v0,
            account_obj_id : _,
            account_id     : _,
        } = arg0;
        0x2::object::delete(v0);
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
        0x2::dynamic_field::borrow<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::IntegratorConfig, IntegratorConfig>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::integrator_config(arg1))
    }

    public fun get_integrator_max_taker_fee(arg0: &IntegratorConfig) : u256 {
        arg0.max_taker_fee
    }

    public fun has_authority<T0, T1>(arg0: &AccountCap<T1>, arg1: &Account<T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (arg0.account_id == arg1.account_id) {
            if (v0 == 0x1::type_name::with_defining_ids<ADMIN>()) {
                true
            } else if (v0 == 0x1::type_name::with_defining_ids<ASSISTANT>()) {
                let v2 = 0x2::object::id<AccountCap<T1>>(arg0);
                0x1::vector::contains<0x2::object::ID>(&arg1.active_assistants, &v2)
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun new_assistant_account_cap<T0>(arg0: &mut Account<T0>, arg1: &mut 0x2::tx_context::TxContext) : AccountCap<ASSISTANT> {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.active_assistants) < 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::max_assistats_per_account(), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::too_many_assistants_per_account());
        let v0 = AccountCap<ASSISTANT>{
            id             : 0x2::object::new(arg1),
            account_obj_id : 0x2::object::uid_to_inner(&arg0.id),
            account_id     : arg0.account_id,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_assistants, 0x2::object::uid_to_inner(&v0.id));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_created_assistant_account_cap(arg0.account_id, 0x2::object::uid_to_inner(&v0.id));
        v0
    }

    public(friend) fun remove_integrator_config<T0>(arg0: &mut Account<T0>, arg1: address) {
        let IntegratorConfig {  } = 0x2::dynamic_field::remove<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::IntegratorConfig, IntegratorConfig>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::integrator_config(arg1));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_removed_integrator_config<T0>(arg0.account_id, arg1);
    }

    public(friend) fun revoke_assistant_account_cap<T0>(arg0: &mut Account<T0>, arg1: 0x2::object::ID) {
        let v0 = &arg0.active_assistants;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::remove<0x2::object::ID>(&mut arg0.active_assistants, 0x1::option::destroy_some<u64>(v2));
                    0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_revoked_assistant_account_cap(arg0.account_id, arg1);
                } else {
                    0x1::option::destroy_none<u64>(v2);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun withdraw_collateral<T0>(arg0: &mut Account<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::deposit_or_withdraw_amount_zero());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_withdrew_collateral<T0>(arg0.account_id, arg1);
        0x2::coin::take<T0>(&mut arg0.collateral, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

