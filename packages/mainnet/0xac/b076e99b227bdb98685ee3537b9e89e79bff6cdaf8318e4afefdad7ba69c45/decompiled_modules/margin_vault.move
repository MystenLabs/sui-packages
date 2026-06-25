module 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_vault {
    struct Vault has copy, drop, store {
        owner: address,
        market_id: 0x2::object::ID,
        balance: u64,
    }

    struct VaultKey has copy, drop, store {
        owner: address,
        market_id: 0x2::object::ID,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<VaultKey, Vault>,
        vault_count: u64,
        total_deposited: u128,
    }

    struct VaultCreated has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        initial_deposit: u64,
    }

    struct CollateralDeposited has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct CollateralWithdrawn has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct VaultClosed has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
    }

    public fun borrow_vault(arg0: &VaultRegistry, arg1: address, arg2: 0x2::object::ID) : &Vault {
        let v0 = VaultKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(0x2::table::contains<VaultKey, Vault>(&arg0.vaults, v0), 1);
        0x2::table::borrow<VaultKey, Vault>(&arg0.vaults, v0)
    }

    public(friend) fun create_vault(arg0: &mut VaultRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u64) {
        assert!(arg3 > 0, 2);
        let v0 = VaultKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(!0x2::table::contains<VaultKey, Vault>(&arg0.vaults, v0), 0);
        let v1 = Vault{
            owner     : arg1,
            market_id : arg2,
            balance   : arg3,
        };
        0x2::table::add<VaultKey, Vault>(&mut arg0.vaults, v0, v1);
        arg0.vault_count = arg0.vault_count + 1;
        arg0.total_deposited = arg0.total_deposited + (arg3 as u128);
        let v2 = VaultCreated{
            owner           : arg1,
            market_id       : arg2,
            initial_deposit : arg3,
        };
        0x2::event::emit<VaultCreated>(v2);
    }

    public(friend) fun deposit(arg0: &mut VaultRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u64) {
        assert!(arg3 > 0, 2);
        let v0 = VaultKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(0x2::table::contains<VaultKey, Vault>(&arg0.vaults, v0), 1);
        let v1 = 0x2::table::borrow_mut<VaultKey, Vault>(&mut arg0.vaults, v0);
        v1.balance = v1.balance + arg3;
        arg0.total_deposited = arg0.total_deposited + (arg3 as u128);
        let v2 = CollateralDeposited{
            owner       : arg1,
            market_id   : arg2,
            amount      : arg3,
            new_balance : v1.balance,
        };
        0x2::event::emit<CollateralDeposited>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id              : 0x2::object::new(arg0),
            vaults          : 0x2::table::new<VaultKey, Vault>(arg0),
            vault_count     : 0,
            total_deposited : 0,
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    public fun total_deposited(arg0: &VaultRegistry) : u128 {
        arg0.total_deposited
    }

    public fun vault_balance(arg0: &VaultRegistry, arg1: address, arg2: 0x2::object::ID) : u64 {
        let v0 = VaultKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(0x2::table::contains<VaultKey, Vault>(&arg0.vaults, v0), 1);
        0x2::table::borrow<VaultKey, Vault>(&arg0.vaults, v0).balance
    }

    public fun vault_balance_value(arg0: &Vault) : u64 {
        arg0.balance
    }

    public fun vault_count(arg0: &VaultRegistry) : u64 {
        arg0.vault_count
    }

    public fun vault_exists(arg0: &VaultRegistry, arg1: address, arg2: 0x2::object::ID) : bool {
        let v0 = VaultKey{
            owner     : arg1,
            market_id : arg2,
        };
        0x2::table::contains<VaultKey, Vault>(&arg0.vaults, v0)
    }

    public fun vault_market_id(arg0: &Vault) : 0x2::object::ID {
        arg0.market_id
    }

    public fun vault_owner(arg0: &Vault) : address {
        arg0.owner
    }

    public(friend) fun withdraw(arg0: &mut VaultRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u64) {
        assert!(arg3 > 0, 3);
        let v0 = VaultKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(0x2::table::contains<VaultKey, Vault>(&arg0.vaults, v0), 1);
        let v1 = 0x2::table::borrow<VaultKey, Vault>(&arg0.vaults, v0);
        assert!(arg3 <= v1.balance, 4);
        let v2 = v1.balance - arg3;
        if (v2 == 0) {
            0x2::table::remove<VaultKey, Vault>(&mut arg0.vaults, v0);
            arg0.vault_count = arg0.vault_count - 1;
            arg0.total_deposited = arg0.total_deposited - (arg3 as u128);
            let v3 = CollateralWithdrawn{
                owner       : arg1,
                market_id   : arg2,
                amount      : arg3,
                new_balance : 0,
            };
            0x2::event::emit<CollateralWithdrawn>(v3);
            let v4 = VaultClosed{
                owner     : arg1,
                market_id : arg2,
            };
            0x2::event::emit<VaultClosed>(v4);
        } else {
            0x2::table::borrow_mut<VaultKey, Vault>(&mut arg0.vaults, v0).balance = v2;
            arg0.total_deposited = arg0.total_deposited - (arg3 as u128);
            let v5 = CollateralWithdrawn{
                owner       : arg1,
                market_id   : arg2,
                amount      : arg3,
                new_balance : v2,
            };
            0x2::event::emit<CollateralWithdrawn>(v5);
        };
    }

    // decompiled from Move bytecode v7
}

