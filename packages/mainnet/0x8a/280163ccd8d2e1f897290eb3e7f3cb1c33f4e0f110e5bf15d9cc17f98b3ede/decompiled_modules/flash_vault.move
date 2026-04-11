module 0x8a280163ccd8d2e1f897290eb3e7f3cb1c33f4e0f110e5bf15d9cc17f98b3ede::flash_vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
        total_borrows: u64,
        total_profit: u64,
    }

    struct FlashReceipt<phantom T0> {
        vault_id: address,
        borrow_amount: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        owner: address,
    }

    struct FlashBorrow has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct FlashRepay has copy, drop {
        vault_id: address,
        returned: u64,
        borrowed: u64,
        profit: u64,
    }

    public fun borrow<T0>(arg0: &mut Vault<T0>, arg1: u64) : (0x2::balance::Balance<T0>, FlashReceipt<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 2);
        arg0.total_borrows = arg0.total_borrows + 1;
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = FlashBorrow{
            vault_id : v0,
            amount   : arg1,
        };
        0x2::event::emit<FlashBorrow>(v1);
        let v2 = FlashReceipt<T0>{
            vault_id      : v0,
            borrow_amount : arg1,
        };
        (0x2::balance::split<T0>(&mut arg0.balance, arg1), v2)
    }

    public entry fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id            : 0x2::object::new(arg0),
            balance       : 0x2::balance::zero<T0>(),
            owner         : 0x2::tx_context::sender(arg0),
            total_borrows : 0,
            total_profit  : 0,
        };
        let v1 = VaultCreated{
            vault_id : 0x2::object::uid_to_address(&v0.id),
            owner    : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun receipt_amount<T0>(arg0: &FlashReceipt<T0>) : u64 {
        arg0.borrow_amount
    }

    public fun repay<T0>(arg0: &mut Vault<T0>, arg1: FlashReceipt<T0>, arg2: 0x2::balance::Balance<T0>) {
        let FlashReceipt {
            vault_id      : _,
            borrow_amount : v1,
        } = arg1;
        let v2 = 0x2::balance::value<T0>(&arg2);
        assert!(v2 >= v1, 1);
        let v3 = v2 - v1;
        arg0.total_profit = arg0.total_profit + v3;
        let v4 = FlashRepay{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            returned : v2,
            borrowed : v1,
            profit   : v3,
        };
        0x2::event::emit<FlashRepay>(v4);
        0x2::balance::join<T0>(&mut arg0.balance, arg2);
    }

    public fun total_borrows<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_borrows
    }

    public fun total_profit<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_profit
    }

    public fun vault_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

