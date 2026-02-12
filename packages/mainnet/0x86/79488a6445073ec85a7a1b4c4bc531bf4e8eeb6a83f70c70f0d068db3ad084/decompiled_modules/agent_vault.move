module 0x8679488a6445073ec85a7a1b4c4bc531bf4e8eeb6a83f70c70f0d068db3ad084::agent_vault {
    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        policy: Policy,
        authorized_caps: vector<0x2::object::ID>,
        total_spent: u64,
        last_tx_time: u64,
        tx_count: u64,
    }

    struct Policy has copy, drop, store {
        max_budget: u64,
        max_per_tx: u64,
        allowed_actions: vector<u8>,
        cooldown_ms: u64,
        expires_at: u64,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        initial_balance: u64,
        max_budget: u64,
    }

    struct AgentWithdrawal has copy, drop {
        vault_id: 0x2::object::ID,
        agent_cap_id: 0x2::object::ID,
        amount: u64,
        action_type: u8,
        total_spent: u64,
        remaining_budget: u64,
        tx_count: u64,
        timestamp: u64,
    }

    struct PolicyUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        max_budget: u64,
        max_per_tx: u64,
        cooldown_ms: u64,
        expires_at: u64,
    }

    struct AgentCapCreated has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        agent_address: address,
    }

    struct AgentCapRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct WithdrawnAll has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun agent_withdraw(arg0: &mut Vault, arg1: &AgentCap, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg2 > 0, 8);
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        let v0 = 0x2::object::id<AgentCap>(arg1);
        let (v1, _) = 0x1::vector::index_of<0x2::object::ID>(&arg0.authorized_caps, &v0);
        assert!(v1, 5);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        assert!(v3 < arg0.policy.expires_at, 3);
        if (arg0.tx_count > 0) {
            assert!(v3 - arg0.last_tx_time >= arg0.policy.cooldown_ms, 4);
        };
        assert!(arg2 <= arg0.policy.max_per_tx, 7);
        assert!(arg2 <= arg0.policy.max_budget - arg0.total_spent, 1);
        assert!(0x1::vector::contains<u8>(&arg0.policy.allowed_actions, &arg3), 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui) >= arg2, 6);
        arg0.total_spent = arg0.total_spent + arg2;
        arg0.last_tx_time = v3;
        arg0.tx_count = arg0.tx_count + 1;
        let v4 = AgentWithdrawal{
            vault_id         : 0x2::object::id<Vault>(arg0),
            agent_cap_id     : 0x2::object::id<AgentCap>(arg1),
            amount           : arg2,
            action_type      : arg3,
            total_spent      : arg0.total_spent,
            remaining_budget : arg0.policy.max_budget - arg0.total_spent,
            tx_count         : arg0.tx_count,
            timestamp        : v3,
        };
        0x2::event::emit<AgentWithdrawal>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_sui, arg2), arg5)
    }

    public fun create_agent_cap(arg0: &mut Vault, arg1: &OwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 0);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = AgentCap{
            id       : v0,
            vault_id : 0x2::object::id<Vault>(arg0),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.authorized_caps, v1);
        let v3 = AgentCapCreated{
            vault_id      : 0x2::object::id<Vault>(arg0),
            cap_id        : v1,
            agent_address : arg2,
        };
        0x2::event::emit<AgentCapCreated>(v3);
        0x2::transfer::transfer<AgentCap>(v2, arg2);
    }

    public fun create_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Policy{
            max_budget      : arg1,
            max_per_tx      : arg2,
            allowed_actions : arg3,
            cooldown_ms     : arg4,
            expires_at      : arg5,
        };
        let v3 = Vault{
            id              : v0,
            owner           : 0x2::tx_context::sender(arg7),
            balance_sui     : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            policy          : v2,
            authorized_caps : 0x1::vector::empty<0x2::object::ID>(),
            total_spent     : 0,
            last_tx_time    : 0,
            tx_count        : 0,
        };
        let v4 = OwnerCap{
            id       : 0x2::object::new(arg7),
            vault_id : v1,
        };
        let v5 = VaultCreated{
            vault_id        : v1,
            owner           : 0x2::tx_context::sender(arg7),
            initial_balance : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            max_budget      : arg1,
        };
        0x2::event::emit<VaultCreated>(v5);
        0x2::transfer::share_object<Vault>(v3);
        0x2::transfer::transfer<OwnerCap>(v4, 0x2::tx_context::sender(arg7));
    }

    public fun deposit(arg0: &mut Vault, arg1: &OwnerCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = Deposited{
            vault_id    : 0x2::object::id<Vault>(arg0),
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun get_agent_cap_vault_id(arg0: &AgentCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun get_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui)
    }

    public fun get_owner(arg0: &Vault) : address {
        arg0.owner
    }

    public fun get_owner_cap_vault_id(arg0: &OwnerCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun get_policy_cooldown_ms(arg0: &Vault) : u64 {
        arg0.policy.cooldown_ms
    }

    public fun get_policy_expires_at(arg0: &Vault) : u64 {
        arg0.policy.expires_at
    }

    public fun get_policy_max_budget(arg0: &Vault) : u64 {
        arg0.policy.max_budget
    }

    public fun get_policy_max_per_tx(arg0: &Vault) : u64 {
        arg0.policy.max_per_tx
    }

    public fun get_total_spent(arg0: &Vault) : u64 {
        arg0.total_spent
    }

    public fun get_tx_count(arg0: &Vault) : u64 {
        arg0.tx_count
    }

    public fun reset_counters(arg0: &mut Vault, arg1: &OwnerCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 0);
        arg0.total_spent = 0;
        arg0.tx_count = 0;
        arg0.last_tx_time = 0;
    }

    public fun revoke_agent_cap(arg0: &mut Vault, arg1: &OwnerCap, arg2: 0x2::object::ID) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 0);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.authorized_caps, &arg2);
        assert!(v0, 5);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.authorized_caps, v1);
        let v2 = AgentCapRevoked{
            vault_id : 0x2::object::id<Vault>(arg0),
            cap_id   : arg2,
        };
        0x2::event::emit<AgentCapRevoked>(v2);
    }

    public fun update_policy(arg0: &mut Vault, arg1: &OwnerCap, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 0);
        let v0 = Policy{
            max_budget      : arg2,
            max_per_tx      : arg3,
            allowed_actions : arg4,
            cooldown_ms     : arg5,
            expires_at      : arg6,
        };
        arg0.policy = v0;
        let v1 = PolicyUpdated{
            vault_id    : 0x2::object::id<Vault>(arg0),
            max_budget  : arg2,
            max_per_tx  : arg3,
            cooldown_ms : arg5,
            expires_at  : arg6,
        };
        0x2::event::emit<PolicyUpdated>(v1);
    }

    public fun withdraw(arg0: &mut Vault, arg1: &OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 0);
        assert!(arg2 > 0, 8);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui) >= arg2, 6);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_sui, arg2), arg3)
    }

    public fun withdraw_all(arg0: &mut Vault, arg1: &OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui);
        let v1 = WithdrawnAll{
            vault_id : 0x2::object::id<Vault>(arg0),
            amount   : v0,
        };
        0x2::event::emit<WithdrawnAll>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_sui, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

