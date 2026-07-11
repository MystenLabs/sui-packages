module 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u16,
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

    struct VaultMigrated has copy, drop {
        vault_id: 0x2::object::ID,
        from_version: u16,
        to_version: u16,
    }

    public fun value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun new<T0>(arg0: &0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::AgentPolicy, arg1: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        let v0 = Vault<T0>{
            id        : 0x2::object::new(arg1),
            version   : 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::version(),
            policy_id : 0x2::object::id<0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::AgentPolicy>(arg0),
            owner     : 0x2::tx_context::sender(arg1),
            balance   : 0x2::balance::zero<T0>(),
        };
        let v1 = VaultOpened{
            vault_id  : 0x2::object::id<Vault<T0>>(&v0),
            policy_id : 0x2::object::id<0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::AgentPolicy>(arg0),
            owner     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<VaultOpened>(v1);
        v0
    }

    public fun version<T0>(arg0: &Vault<T0>) : u16 {
        arg0.version
    }

    public fun owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
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

    public fun migrate<T0>(arg0: &mut Vault<T0>, arg1: &0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::PolicyOwnerCap) {
        assert!(0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::owner_cap_policy_id(arg1) == arg0.policy_id, 2);
        let v0 = arg0.version;
        assert!(v0 < 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::version(), 4);
        arg0.version = 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::version();
        let v1 = VaultMigrated{
            vault_id     : 0x2::object::id<Vault<T0>>(arg0),
            from_version : v0,
            to_version   : arg0.version,
        };
        0x2::event::emit<VaultMigrated>(v1);
    }

    entry fun open<T0>(arg0: &0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::AgentPolicy, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Vault<T0>>(new<T0>(arg0, arg1));
    }

    public fun owner_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::PolicyOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::owner_cap_policy_id(arg1) == arg0.policy_id, 2);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 1);
        let v0 = VaultWithdrawn{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : arg2,
            by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<VaultWithdrawn>(v0);
        0x2::coin::take<T0>(&mut arg0.balance, arg2, arg3)
    }

    entry fun owner_withdraw_to<T0>(arg0: &mut Vault<T0>, arg1: &0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::PolicyOwnerCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(owner_withdraw<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun policy_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.policy_id
    }

    entry fun provision<T0>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: vector<address>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::new_policy(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        let v2 = v0;
        let v3 = new<T0>(&v2, arg9);
        let v4 = &mut v3;
        deposit<T0>(v4, arg7);
        0x2::transfer::public_transfer<0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::PolicyOwnerCap>(v1, 0x2::tx_context::sender(arg9));
        0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::share_policy(v2);
        0x2::transfer::share_object<Vault<T0>>(v3);
    }

    public fun vault_spend<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::AgentPolicy, arg2: u64, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::receipt::ActionReceipt) {
        assert!(arg0.version == 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::version(), 3);
        assert!(arg0.policy_id == 0x2::object::id<0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::AgentPolicy>(arg1), 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 1);
        let v0 = VaultSpent{
            vault_id  : 0x2::object::id<Vault<T0>>(arg0),
            policy_id : 0x2::object::id<0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::AgentPolicy>(arg1),
            amount    : arg2,
            balance   : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<VaultSpent>(v0);
        (0x2::coin::take<T0>(&mut arg0.balance, arg2, arg7), 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::enforce_spend<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    public fun vault_transfer<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::AgentPolicy, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::assert_recipient_allowed(arg1, arg3);
        let (v0, v1) = vault_spend<T0>(arg0, arg1, arg2, 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::no_protocol(), b"transfer", arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
        0x2::transfer::public_transfer<0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::receipt::ActionReceipt>(v1, 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy::owner(arg1));
    }

    // decompiled from Move bytecode v7
}

