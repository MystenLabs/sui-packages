module 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_vault {
    struct AgentVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        agent_cap_id: address,
        total_deposited: u64,
        total_withdrawn: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        agent_cap_id: address,
        initial_balance: u64,
    }

    struct VaultDeposit has copy, drop {
        vault_id: address,
        amount: u64,
        new_balance: u64,
    }

    struct VaultWithdraw has copy, drop {
        vault_id: address,
        amount: u64,
        remaining: u64,
        protocol: address,
    }

    struct VaultEmergencyDrain has copy, drop {
        vault_id: address,
        amount: u64,
    }

    public fun admin_withdraw_all(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: &mut AgentVault, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        arg1.total_withdrawn = arg1.total_withdrawn + v0;
        let v1 = VaultEmergencyDrain{
            vault_id : 0x2::object::uid_to_address(&arg1.id),
            amount   : v0,
        };
        0x2::event::emit<VaultEmergencyDrain>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg2)
    }

    public fun agent_withdraw(arg0: &mut AgentVault, arg1: &mut 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AgentCap, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::SpendReceipt) {
        assert!(0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::cap_id(arg1) == arg0.agent_cap_id, 101);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 100);
        arg0.total_withdrawn = arg0.total_withdrawn + arg2;
        let v0 = VaultWithdraw{
            vault_id  : 0x2::object::uid_to_address(&arg0.id),
            amount    : arg2,
            remaining : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
            protocol  : arg3,
        };
        0x2::event::emit<VaultWithdraw>(v0);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg6), 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::authorize_spend(arg1, arg2, arg3, arg4, arg5))
    }

    public fun create_vault(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = AgentVault{
            id              : 0x2::object::new(arg3),
            balance         : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            agent_cap_id    : arg2,
            total_deposited : v0,
            total_withdrawn : 0,
        };
        let v2 = VaultCreated{
            vault_id        : 0x2::object::uid_to_address(&v1.id),
            agent_cap_id    : arg2,
            initial_balance : v0,
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<AgentVault>(v1);
    }

    public fun deposit(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: &mut AgentVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        arg1.total_deposited = arg1.total_deposited + v0;
        let v1 = VaultDeposit{
            vault_id    : 0x2::object::uid_to_address(&arg1.id),
            amount      : v0,
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg1.balance) + v0,
        };
        0x2::event::emit<VaultDeposit>(v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun vault_agent_cap(arg0: &AgentVault) : address {
        arg0.agent_cap_id
    }

    public fun vault_balance(arg0: &AgentVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun vault_total_deposited(arg0: &AgentVault) : u64 {
        arg0.total_deposited
    }

    public fun vault_total_withdrawn(arg0: &AgentVault) : u64 {
        arg0.total_withdrawn
    }

    // decompiled from Move bytecode v7
}

