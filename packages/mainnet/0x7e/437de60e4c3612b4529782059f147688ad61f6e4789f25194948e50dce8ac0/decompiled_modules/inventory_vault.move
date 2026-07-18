module 0x7e437de60e4c3612b4529782059f147688ad61f6e4789f25194948e50dce8ac0::inventory_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        admin_id: 0x2::object::ID,
        funds: 0x2::balance::Balance<T0>,
        minimum_reserve: u64,
        maximum_per_transaction: u64,
        enabled: bool,
    }

    struct InventoryReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        principal: u64,
    }

    struct InventoryBorrowed<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct InventoryRepaid<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        principal: u64,
        profit: u64,
    }

    struct InventoryWithdrawn<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct VaultClosed<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun borrow<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64) : (0x2::balance::Balance<T0>, InventoryReceipt<T0>) {
        assert_admin<T0>(arg0, arg1);
        assert_current_version<T0>(arg0);
        assert!(arg0.enabled, 1);
        assert!(arg2 > 0, 2);
        assert!(arg2 <= arg0.maximum_per_transaction, 3);
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        assert!(v0 >= arg2 && v0 - arg2 >= arg0.minimum_reserve, 4);
        let v1 = 0x2::object::id<Vault<T0>>(arg0);
        let v2 = InventoryBorrowed<T0>{
            vault_id : v1,
            amount   : arg2,
        };
        0x2::event::emit<InventoryBorrowed<T0>>(v2);
        let v3 = InventoryReceipt<T0>{
            vault_id  : v1,
            principal : arg2,
        };
        (0x2::balance::split<T0>(&mut arg0.funds, arg2), v3)
    }

    public fun balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    fun assert_admin<T0>(arg0: &Vault<T0>, arg1: &AdminCap) {
        assert!(arg0.admin_id == 0x2::object::id<AdminCap>(arg1), 0);
    }

    fun assert_current_version<T0>(arg0: &Vault<T0>) {
        assert!(arg0.version == 1, 8);
    }

    public fun available_to_borrow<T0>(arg0: &Vault<T0>) : u64 {
        if (!arg0.enabled) {
            0
        } else {
            let v1 = 0x2::balance::value<T0>(&arg0.funds);
            if (v1 <= arg0.minimum_reserve) {
                0
            } else {
                let v2 = v1 - arg0.minimum_reserve;
                if (v2 < arg0.maximum_per_transaction) {
                    v2
                } else {
                    arg0.maximum_per_transaction
                }
            }
        }
    }

    public fun close<T0>(arg0: Vault<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_admin<T0>(&arg0, arg1);
        assert_current_version<T0>(&arg0);
        assert!(!arg0.enabled, 1);
        let Vault {
            id                      : v0,
            version                 : _,
            admin_id                : _,
            funds                   : v3,
            minimum_reserve         : _,
            maximum_per_transaction : _,
            enabled                 : _,
        } = arg0;
        let v7 = v3;
        let v8 = v0;
        0x2::object::delete(v8);
        let v9 = VaultClosed<T0>{
            vault_id : 0x2::object::uid_to_inner(&v8),
            amount   : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<VaultClosed<T0>>(v9);
        0x2::coin::from_balance<T0>(v7, arg2)
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (Vault<T0>, AdminCap) {
        assert!(arg2 > 0, 7);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::coin::into_balance<T0>(arg0);
        assert!(0x2::balance::value<T0>(&v1) >= arg1, 7);
        let v2 = Vault<T0>{
            id                      : 0x2::object::new(arg3),
            version                 : 1,
            admin_id                : 0x2::object::id<AdminCap>(&v0),
            funds                   : v1,
            minimum_reserve         : arg1,
            maximum_per_transaction : arg2,
            enabled                 : false,
        };
        (v2, v0)
    }

    public fun current_version() : u64 {
        1
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert_current_version<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun enabled<T0>(arg0: &Vault<T0>) : bool {
        arg0.enabled
    }

    public fun maximum_per_transaction<T0>(arg0: &Vault<T0>) : u64 {
        arg0.maximum_per_transaction
    }

    public fun migrate<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap) {
        assert_admin<T0>(arg0, arg1);
        assert!(arg0.version == 0, 9);
        arg0.version = 1;
    }

    public fun minimum_reserve<T0>(arg0: &Vault<T0>) : u64 {
        arg0.minimum_reserve
    }

    public fun repay<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: InventoryReceipt<T0>) : 0x2::balance::Balance<T0> {
        assert_current_version<T0>(arg0);
        let InventoryReceipt {
            vault_id  : v0,
            principal : v1,
        } = arg2;
        assert!(0x2::object::id<Vault<T0>>(arg0) == v0, 5);
        let v2 = 0x2::balance::value<T0>(&arg1);
        assert!(v2 >= v1, 6);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::balance::split<T0>(&mut arg1, v1));
        let v3 = InventoryRepaid<T0>{
            vault_id  : v0,
            principal : v1,
            profit    : v2 - v1,
        };
        0x2::event::emit<InventoryRepaid<T0>>(v3);
        arg1
    }

    public fun set_policy<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: bool) {
        assert_admin<T0>(arg0, arg1);
        assert_current_version<T0>(arg0);
        assert!(arg3 > 0 && 0x2::balance::value<T0>(&arg0.funds) >= arg2, 7);
        arg0.minimum_reserve = arg2;
        arg0.maximum_per_transaction = arg3;
        arg0.enabled = arg4;
    }

    public fun version<T0>(arg0: &Vault<T0>) : u64 {
        arg0.version
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_admin<T0>(arg0, arg1);
        assert_current_version<T0>(arg0);
        assert!(!arg0.enabled, 1);
        assert!(arg2 > 0, 2);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.funds), 4);
        let v0 = InventoryWithdrawn<T0>{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : arg2,
        };
        0x2::event::emit<InventoryWithdrawn<T0>>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

