module 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy {
    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Policy has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        destination: address,
        agent: address,
        suspended: bool,
        allowed_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        cap_id: 0x2::object::ID,
    }

    struct Routed has copy, drop {
        policy_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        coin_type: vector<u8>,
        amount: u64,
        destination: address,
    }

    struct Swapped has copy, drop {
        policy_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_paid: u64,
        amount_out: u64,
        destination: address,
    }

    struct PolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        destination: address,
        agent: address,
        suspended: bool,
    }

    public fun agent(arg0: &Policy) : address {
        arg0.agent
    }

    fun assert_agent_gates(arg0: &Policy, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::Vault, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.agent, 13906835595977555969);
        assert!(!arg0.suspended, 13906835600272654339);
        assert!(0x2::object::id<0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::Vault>(arg1) == arg0.vault_id, 13906835604567752709);
    }

    fun assert_binding(arg0: &Policy, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap) {
        assert!(0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::owner_cap_vault_id(arg1) == arg0.vault_id, 13906835634632654855);
    }

    public fun cap_id(arg0: &Policy) : 0x2::object::ID {
        arg0.cap_id
    }

    public fun create(arg0: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::Vault, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg2: address, arg3: address, arg4: 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::SpenderCap, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::Vault>(arg0);
        assert!(0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::owner_cap_vault_id(arg1) == v0, 13906834685444882439);
        assert!(0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::spender_cap_vault_id(&arg4) == v0, 13906834689739718661);
        let v1 = Policy{
            id            : 0x2::object::new(arg5),
            vault_id      : v0,
            destination   : arg3,
            agent         : arg2,
            suspended     : false,
            allowed_pools : 0x2::vec_set::empty<0x2::object::ID>(),
            cap_id        : 0x2::object::id<0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::SpenderCap>(&arg4),
        };
        let v2 = 0x2::object::id<Policy>(&v1);
        let v3 = CapKey{dummy_field: false};
        0x2::dynamic_object_field::add<CapKey, 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::SpenderCap>(&mut v1.id, v3, arg4);
        0x2::transfer::share_object<Policy>(v1);
        let v4 = PolicyUpdated{
            policy_id   : v2,
            destination : arg3,
            agent       : arg2,
            suspended   : false,
        };
        0x2::event::emit<PolicyUpdated>(v4);
        v2
    }

    public fun destination(arg0: &Policy) : address {
        arg0.destination
    }

    fun emit_updated(arg0: &Policy) {
        let v0 = PolicyUpdated{
            policy_id   : 0x2::object::id<Policy>(arg0),
            destination : arg0.destination,
            agent       : arg0.agent,
            suspended   : arg0.suspended,
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun is_pool_allowed(arg0: &Policy, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &arg1)
    }

    public fun is_suspended(arg0: &Policy) : bool {
        arg0.suspended
    }

    public fun set_agent(arg0: &mut Policy, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg2: address) {
        assert_binding(arg0, arg1);
        arg0.agent = arg2;
        emit_updated(arg0);
    }

    public fun set_destination(arg0: &mut Policy, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg2: address) {
        assert_binding(arg0, arg1);
        arg0.destination = arg2;
        emit_updated(arg0);
    }

    public fun set_pool_allowed(arg0: &mut Policy, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg2: 0x2::object::ID, arg3: bool) {
        assert_binding(arg0, arg1);
        if (arg3) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_pools, arg2);
        } else {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_pools, &arg2);
        };
        emit_updated(arg0);
    }

    public fun set_suspended(arg0: &mut Policy, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg2: bool) {
        assert_binding(arg0, arg1);
        arg0.suspended = arg2;
        emit_updated(arg0);
    }

    public fun spend_to_destination<T0>(arg0: &mut Policy, arg1: &mut 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::Vault, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_agent_gates(arg0, arg1, arg4);
        let v0 = arg0.destination;
        let v1 = CapKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::spend<T0>(arg1, 0x2::dynamic_object_field::borrow<CapKey, 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::SpenderCap>(&arg0.id, v1), arg2, arg3, arg4), arg4), v0);
        let v2 = Routed{
            policy_id   : 0x2::object::id<Policy>(arg0),
            vault_id    : arg0.vault_id,
            cap_id      : arg0.cap_id,
            coin_type   : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            amount      : arg2,
            destination : v0,
        };
        0x2::event::emit<Routed>(v2);
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::Vault, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::SpenderCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, true, true, arg4, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v6 = 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::spend<T0>(arg0, arg1, arg4, arg6, arg8);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::split<T0>(&mut v6, v5), 0x2::balance::zero<T1>(), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg8), arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg8), arg7);
        (v5, 0x2::balance::value<T1>(&v4))
    }

    public fun swap_and_route<T0, T1>(arg0: &mut Policy, arg1: &mut 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::Vault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_agent_gates(arg0, arg1, arg8);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &v0), 13906835196546121737);
        let v1 = arg0.destination;
        let v2 = CapKey{dummy_field: false};
        let (v3, v4) = if (arg4) {
            swap_a2b<T0, T1>(arg1, 0x2::dynamic_object_field::borrow<CapKey, 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::SpenderCap>(&arg0.id, v2), arg2, arg3, arg5, arg6, arg7, v1, arg8)
        } else {
            swap_b2a<T0, T1>(arg1, 0x2::dynamic_object_field::borrow<CapKey, 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::SpenderCap>(&arg0.id, v2), arg2, arg3, arg5, arg6, arg7, v1, arg8)
        };
        let v5 = Swapped{
            policy_id   : 0x2::object::id<Policy>(arg0),
            vault_id    : arg0.vault_id,
            pool_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            a2b         : arg4,
            amount_in   : arg5,
            amount_paid : v3,
            amount_out  : v4,
            destination : v1,
        };
        0x2::event::emit<Swapped>(v5);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::Vault, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::SpenderCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, false, true, arg4, arg5, arg6);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v6 = 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::spend<T1>(arg0, arg1, arg4, arg6, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v6, v5), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg8), arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg8), arg7);
        (v5, 0x2::balance::value<T0>(&v4))
    }

    public fun vault_id(arg0: &Policy) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

