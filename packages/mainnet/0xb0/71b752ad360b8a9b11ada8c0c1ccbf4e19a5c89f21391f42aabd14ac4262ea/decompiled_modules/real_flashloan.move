module 0xb071b752ad360b8a9b11ada8c0c1ccbf4e19a5c89f21391f42aabd14ac4262ea::real_flashloan {
    struct FlashloanVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        total_borrowed: u64,
        total_repaid: u64,
        fee_basis_points: u64,
    }

    struct FlashloanReceipt<phantom T0> {
        borrowed_amount: u64,
        fee: u64,
    }

    struct FlashloanBorrowed has copy, drop {
        vault_id: address,
        borrower: address,
        amount: u64,
        fee: u64,
    }

    struct FlashloanRepaid has copy, drop {
        vault_id: address,
        borrower: address,
        amount: u64,
        fee: u64,
    }

    public fun borrow<T0>(arg0: &mut FlashloanVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashloanReceipt<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 0);
        let v0 = arg1 * arg0.fee_basis_points / 10000;
        let v1 = FlashloanReceipt<T0>{
            borrowed_amount : arg1,
            fee             : v0,
        };
        arg0.total_borrowed = arg0.total_borrowed + arg1;
        let v2 = FlashloanBorrowed{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            borrower : 0x2::tx_context::sender(arg2),
            amount   : arg1,
            fee      : v0,
        };
        0x2::event::emit<FlashloanBorrowed>(v2);
        (0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), v1)
    }

    public entry fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashloanVault<T0>{
            id               : 0x2::object::new(arg2),
            balance          : 0x2::coin::into_balance<T0>(arg0),
            total_borrowed   : 0,
            total_repaid     : 0,
            fee_basis_points : arg1,
        };
        0x2::transfer::share_object<FlashloanVault<T0>>(v0);
    }

    public entry fun fund_vault<T0>(arg0: &mut FlashloanVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_vault_stats<T0>(arg0: &FlashloanVault<T0>) : (u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance), arg0.total_borrowed, arg0.total_repaid, arg0.fee_basis_points)
    }

    public fun repay<T0>(arg0: &mut FlashloanVault<T0>, arg1: FlashloanReceipt<T0>, arg2: 0x2::coin::Coin<T0>) {
        let FlashloanReceipt {
            borrowed_amount : v0,
            fee             : v1,
        } = arg1;
        assert!(0x2::coin::value<T0>(&arg2) >= v0 + v1, 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_repaid = arg0.total_repaid + v0;
        let v2 = FlashloanRepaid{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            borrower : @0x0,
            amount   : v0,
            fee      : v1,
        };
        0x2::event::emit<FlashloanRepaid>(v2);
    }

    public entry fun test_flashloan<T0>(arg0: &mut FlashloanVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = borrow<T0>(arg0, arg1, arg2);
        repay<T0>(arg0, v1, v0);
    }

    // decompiled from Move bytecode v6
}

