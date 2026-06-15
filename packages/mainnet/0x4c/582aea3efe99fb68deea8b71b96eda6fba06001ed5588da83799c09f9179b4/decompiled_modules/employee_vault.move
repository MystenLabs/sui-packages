module 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault {
    struct EmployeeVault has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct TokenBucket<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct TokenKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct BucketInitialized has copy, drop {
        vault_id: 0x2::object::ID,
        token: 0x1::string::String,
    }

    struct BucketDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        token: 0x1::string::String,
        amount: u64,
    }

    struct BucketWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        token: 0x1::string::String,
        amount: u64,
    }

    public fun borrow_bucket_mut<T0>(arg0: &mut EmployeeVault, arg1: 0x1::string::String) : &mut TokenBucket<T0> {
        let v0 = TokenKey{pos0: arg1};
        assert!(0x2::dynamic_object_field::exists<TokenKey>(&arg0.id, v0), 13906834535120764931);
        let v1 = TokenKey{pos0: arg1};
        0x2::dynamic_object_field::borrow_mut<TokenKey, TokenBucket<T0>>(&mut arg0.id, v1)
    }

    public fun bucket_balance<T0>(arg0: &EmployeeVault, arg1: 0x1::string::String) : u64 {
        let v0 = TokenKey{pos0: arg1};
        if (!0x2::dynamic_object_field::exists<TokenKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = TokenKey{pos0: arg1};
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<TokenKey, TokenBucket<T0>>(&arg0.id, v1).balance)
    }

    public fun bucket_exists(arg0: &EmployeeVault, arg1: 0x1::string::String) : bool {
        let v0 = TokenKey{pos0: arg1};
        0x2::dynamic_object_field::exists<TokenKey>(&arg0.id, v0)
    }

    public fun bucket_uid_mut<T0>(arg0: &mut TokenBucket<T0>, arg1: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    entry fun create_and_keep(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_vault(arg0);
        0x2::transfer::transfer<EmployeeVault>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) : EmployeeVault {
        let v0 = EmployeeVault{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        let v1 = VaultCreated{
            vault_id : 0x2::object::uid_to_inner(&v0.id),
            owner    : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<VaultCreated>(v1);
        v0
    }

    public fun deposit_to_bucket<T0>(arg0: &mut EmployeeVault, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 13906834432041418753);
        let v0 = TokenKey{pos0: arg1};
        assert!(0x2::dynamic_object_field::exists<TokenKey>(&arg0.id, v0), 13906834436336517123);
        let v1 = TokenKey{pos0: arg1};
        0x2::balance::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<TokenKey, TokenBucket<T0>>(&mut arg0.id, v1).balance, 0x2::coin::into_balance<T0>(arg2));
        let v2 = BucketDeposited{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            token    : arg1,
            amount   : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<BucketDeposited>(v2);
    }

    public fun init_bucket<T0>(arg0: &mut EmployeeVault, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 13906834363321942017);
        let v0 = TokenKey{pos0: arg1};
        assert!(!0x2::dynamic_object_field::exists<TokenKey>(&arg0.id, v0), 13906834367617171461);
        let v1 = TokenKey{pos0: arg1};
        let v2 = TokenBucket<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::dynamic_object_field::add<TokenKey, TokenBucket<T0>>(&mut arg0.id, v1, v2);
        let v3 = BucketInitialized{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            token    : arg1,
        };
        0x2::event::emit<BucketInitialized>(v3);
    }

    public fun merge_bucket_from_yield<T0>(arg0: &mut TokenBucket<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun owner(arg0: &EmployeeVault) : address {
        arg0.owner
    }

    public fun split_bucket_for_invest<T0>(arg0: &mut TokenBucket<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 13906834681149915143);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public fun vault_uid(arg0: &EmployeeVault) : &0x2::object::UID {
        &arg0.id
    }

    public fun vault_uid_mut(arg0: &mut EmployeeVault, arg1: &0x2::tx_context::TxContext) : &mut 0x2::object::UID {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 13906834625314947073);
        &mut arg0.id
    }

    public fun withdraw_from_bucket<T0>(arg0: &mut EmployeeVault, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 13906834492170960897);
        let v0 = TokenKey{pos0: arg1};
        assert!(0x2::dynamic_object_field::exists<TokenKey>(&arg0.id, v0), 13906834496466059267);
        let v1 = TokenKey{pos0: arg1};
        let v2 = 0x2::dynamic_object_field::borrow_mut<TokenKey, TokenBucket<T0>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T0>(&v2.balance) >= arg2, 13906834505056256007);
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.balance, arg2), arg3);
        let v4 = BucketWithdrawn{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            token    : arg1,
            amount   : arg2,
        };
        0x2::event::emit<BucketWithdrawn>(v4);
        v3
    }

    // decompiled from Move bytecode v7
}

