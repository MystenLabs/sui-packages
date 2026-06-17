module 0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
    }

    struct VaultOpened has copy, drop {
        vault_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        owner: address,
    }

    struct VaultDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        balance: u64,
    }

    struct VaultSpent has copy, drop {
        vault_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        amount: u64,
        balance: u64,
    }

    struct VaultWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        by: address,
    }

    public fun value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun new<T0>(arg0: &0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::AgentPolicy, arg1: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        let v0 = Vault<T0>{
            id        : 0x2::object::new(arg1),
            policy_id : 0x2::object::id<0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::AgentPolicy>(arg0),
            owner     : 0x2::tx_context::sender(arg1),
            balance   : 0x2::balance::zero<T0>(),
        };
        let v1 = VaultOpened{
            vault_id  : 0x2::object::id<Vault<T0>>(&v0),
            policy_id : 0x2::object::id<0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::AgentPolicy>(arg0),
            owner     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<VaultOpened>(v1);
        v0
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = VaultDeposited{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : 0x2::coin::value<T0>(&arg1),
            balance  : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<VaultDeposited>(v0);
    }

    entry fun deposit_entry<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        deposit<T0>(arg0, arg1);
    }

    entry fun open<T0>(arg0: &0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::AgentPolicy, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Vault<T0>>(new<T0>(arg0, arg1));
    }

    public fun owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun owner_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::PolicyOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::owner_cap_policy_id(arg1) == arg0.policy_id, 2);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 1);
        let v0 = VaultWithdrawn{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : arg2,
            by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<VaultWithdrawn>(v0);
        0x2::coin::take<T0>(&mut arg0.balance, arg2, arg3)
    }

    entry fun owner_withdraw_to<T0>(arg0: &mut Vault<T0>, arg1: &0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::PolicyOwnerCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(owner_withdraw<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun policy_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun vault_spend<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::AgentPolicy, arg2: u64, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::ActionReceipt) {
        assert!(arg0.policy_id == 0x2::object::id<0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::AgentPolicy>(arg1), 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 1);
        let v0 = VaultSpent{
            vault_id  : 0x2::object::id<Vault<T0>>(arg0),
            policy_id : 0x2::object::id<0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::AgentPolicy>(arg1),
            amount    : arg2,
            balance   : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<VaultSpent>(v0);
        (0x2::coin::take<T0>(&mut arg0.balance, arg2, arg7), 0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy::enforce_spend<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    // decompiled from Move bytecode v7
}

