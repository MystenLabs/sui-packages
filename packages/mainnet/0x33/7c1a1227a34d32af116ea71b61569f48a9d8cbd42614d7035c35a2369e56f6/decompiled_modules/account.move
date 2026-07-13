module 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account {
    struct IntegratorConfig has store {
        max_integrator_fee_b9: u32,
    }

    struct IntegratorInfo has copy, drop, store {
        integrator_id: u32,
        integrator_fee: u32,
    }

    struct AccountSharePolicy {
        pos0: 0x2::object::ID,
    }

    struct Account<phantom T0> has store, key {
        id: 0x2::object::UID,
        account_id: u64,
        collateral: 0x2::balance::Balance<T0>,
        active_assistants: vector<0x2::object::ID>,
    }

    public fun account_id<T0>(arg0: &Account<T0>) : u64 {
        arg0.account_id
    }

    public fun add_integrator_config<T0, T1>(arg0: &mut Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, T1>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: u32, arg4: u32) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_package_version(arg2);
        assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_integrator_id_is_valid(arg2, arg3);
        assert!(arg4 != 0 && arg4 <= 10000000, 4001);
        let v0 = IntegratorConfig{max_integrator_fee_b9: arg4};
        0x2::dynamic_field::add<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::IntegratorConfigKey, IntegratorConfig>(&mut arg0.id, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::integrator_config(arg3), v0);
    }

    public(friend) fun add_order_ticket<T0, T1: store + key>(arg0: &mut Account<T0>, arg1: T1) : 0x2::object::ID {
        let v0 = 0x2::object::id<T1>(&arg1);
        0x2::dynamic_field::add<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::OrderTicketKey, T1>(&mut arg0.id, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::order_ticket(v0), arg1);
        v0
    }

    public(friend) fun assert_authority_cap_is_valid<T0, T1>(arg0: &Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = if (0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::for<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, T1>(arg1) == 0x2::object::uid_to_inner(&arg0.id)) {
            if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>()) {
                true
            } else if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>()) {
                let v2 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, T1>>(arg1);
                0x1::vector::contains<0x2::object::ID>(&arg0.active_assistants, &v2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 4000);
    }

    public(friend) fun assert_order_ticket_exists<T0>(arg0: &Account<T0>, arg1: 0x2::object::ID) {
        assert!(has_order_ticket<T0>(arg0, arg1), 4004);
    }

    public(friend) fun borrow_mut_collateral<T0>(arg0: &mut Account<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.collateral
    }

    public(friend) fun borrow_mut_order_ticket<T0, T1: store + key>(arg0: &mut Account<T0>, arg1: 0x2::object::ID) : &mut T1 {
        0x2::dynamic_field::borrow_mut<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::OrderTicketKey, T1>(&mut arg0.id, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::order_ticket(arg1))
    }

    public fun collateral_balance<T0>(arg0: &Account<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun consume_policy_and_share_account<T0>(arg0: Account<T0>, arg1: AccountSharePolicy) {
        let AccountSharePolicy { pos0: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 4003);
        0x2::transfer::share_object<Account<T0>>(arg0);
    }

    public fun create_account<T0>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) : (Account<T0>, AccountSharePolicy, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_package_version(arg0);
        assert!(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::is_collateral_registered<T0>(arg0), 4002);
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::inc_account_id(arg0);
        let v1 = Account<T0>{
            id                : 0x2::derived_object::claim<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::AccountKey>(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::borrow_mut_id(arg0), 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::account(v0)),
            account_id        : v0,
            collateral        : 0x2::balance::zero<T0>(),
            active_assistants : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        let v3 = AccountSharePolicy{pos0: v2};
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_created_account<T0>(v2, 0x2::tx_context::sender(arg1), v0);
        (v1, v3, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::create_account_admin_cap(&mut v1.id, v2))
    }

    public fun create_and_share_account<T0>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN> {
        let (v0, v1, v2) = create_account<T0>(arg0, arg1);
        consume_policy_and_share_account<T0>(v0, v1);
        v2
    }

    public fun create_integrator_info(arg0: u32, arg1: u32) : 0x1::option::Option<IntegratorInfo> {
        assert!(arg1 != 0 && arg1 <= 10000000, 4001);
        let v0 = IntegratorInfo{
            integrator_id  : arg0,
            integrator_fee : arg1,
        };
        0x1::option::some<IntegratorInfo>(v0)
    }

    public fun deposit_collateral<T0, T1>(arg0: &mut Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, T1>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: 0x2::coin::Coin<T0>) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_package_version(arg2);
        assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg3);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
            return
        };
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg3));
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_deposited_collateral<T0>(arg0.account_id, v0);
    }

    public fun destroy_assistant_account_cap<T0>(arg0: &mut Account<T0>, arg1: 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_package_version(arg2);
        assert!(0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::for<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(&arg1) == 0x2::object::uid_to_inner(&arg0.id), 4000);
        let v0 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(&arg1);
        revoke_assistant_account_cap_<T0>(arg0, v0);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::unregister_account_assistant_cap_if_registered(arg2, v0);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::destroy_account_assistant_cap(arg1);
    }

    public fun has_order_ticket<T0>(arg0: &Account<T0>, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::OrderTicketKey>(&arg0.id, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::order_ticket(arg1))
    }

    public fun integrator_config<T0>(arg0: &Account<T0>, arg1: u32) : &IntegratorConfig {
        0x2::dynamic_field::borrow<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::IntegratorConfigKey, IntegratorConfig>(&arg0.id, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::integrator_config(arg1))
    }

    public fun integrator_fee(arg0: &IntegratorInfo) : u256 {
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance((arg0.integrator_fee as u64), 1000000000)
    }

    public fun integrator_fee_b9(arg0: &IntegratorInfo) : u32 {
        arg0.integrator_fee
    }

    public fun integrator_id(arg0: &IntegratorInfo) : u32 {
        arg0.integrator_id
    }

    public fun max_integrator_fee_b9(arg0: &IntegratorConfig) : u32 {
        arg0.max_integrator_fee_b9
    }

    public fun new_assistant_account_cap<T0>(arg0: &mut Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_package_version(arg2);
        assert_authority_cap_is_valid<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg0, arg1);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.active_assistants) < 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::max_assistants_per_account(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::config(arg2)), 4005);
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::create_account_assistant_cap(arg1, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::borrow_mut_id(arg2), arg3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_assistants, 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(&v0));
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::register_account_assistant_cap(arg2, &v0);
        v0
    }

    public fun receive_from_account<T0, T1, T2: store + key>(arg0: &mut Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, T1>, arg2: 0x2::transfer::Receiving<T2>) : T2 {
        assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x2::transfer::public_receive<T2>(&mut arg0.id, arg2)
    }

    public fun remove_integrator_config<T0>(arg0: &mut Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: u32) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_package_version(arg2);
        assert_authority_cap_is_valid<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg0, arg1);
        let IntegratorConfig {  } = 0x2::dynamic_field::remove<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::IntegratorConfigKey, IntegratorConfig>(&mut arg0.id, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::integrator_config(arg3));
    }

    public(friend) fun remove_order_ticket<T0, T1: store + key>(arg0: &mut Account<T0>, arg1: 0x2::object::ID) : T1 {
        0x2::dynamic_field::remove<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::OrderTicketKey, T1>(&mut arg0.id, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::keys::order_ticket(arg1))
    }

    public fun revoke_assistant_account_cap<T0>(arg0: &mut Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: 0x2::object::ID) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_package_version(arg2);
        assert_authority_cap_is_valid<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg0, arg1);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.active_assistants, &arg3), 4000);
        revoke_assistant_account_cap_<T0>(arg0, arg3);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::unregister_account_assistant_cap_if_registered(arg2, arg3);
    }

    fun revoke_assistant_account_cap_<T0>(arg0: &mut Account<T0>, arg1: 0x2::object::ID) {
        let v0 = &arg0.active_assistants;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::remove<0x2::object::ID>(&mut arg0.active_assistants, 0x1::option::destroy_some<u64>(v2));
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

    public(friend) fun validate_session_integrator_info<T0>(arg0: &Account<T0>, arg1: &IntegratorInfo) : u32 {
        assert!(arg1.integrator_fee <= max_integrator_fee_b9(integrator_config<T0>(arg0, arg1.integrator_id)), 4001);
        arg1.integrator_id
    }

    public fun withdraw_collateral<T0>(arg0: &mut Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_package_version(arg2);
        assert_authority_cap_is_valid<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg0, arg1);
        if (arg3 == 0) {
            return 0x2::coin::zero<T0>(arg4)
        };
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_withdrew_collateral<T0>(arg0.account_id, arg3);
        0x2::coin::take<T0>(&mut arg0.collateral, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

