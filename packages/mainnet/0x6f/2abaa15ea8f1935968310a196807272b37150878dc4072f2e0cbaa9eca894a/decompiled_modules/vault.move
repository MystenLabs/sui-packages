module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault {
    struct Vault<phantom T0, phantom T1> has store {
        base_balance: 0x2::balance::Balance<T0>,
        quote_balance: 0x2::balance::Balance<T1>,
        deep_balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
    }

    struct FlashLoan {
        pool_id: 0x2::object::ID,
        borrow_quantity: u64,
        type_name: 0x1::type_name::TypeName,
    }

    struct FlashLoanBorrowed has copy, drop {
        pool_id: 0x2::object::ID,
        borrow_quantity: u64,
        type_name: 0x1::type_name::TypeName,
    }

    public(friend) fun empty<T0, T1>() : Vault<T0, T1> {
        Vault<T0, T1>{
            base_balance  : 0x2::balance::zero<T0>(),
            quote_balance : 0x2::balance::zero<T1>(),
            deep_balance  : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
        }
    }

    public(friend) fun balances<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.base_balance), 0x2::balance::value<T1>(&arg0.quote_balance), 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_balance))
    }

    public(friend) fun borrow_flashloan_base<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan) {
        assert!(arg2 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.base_balance) >= arg2, 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = FlashLoan{
            pool_id         : arg1,
            borrow_quantity : arg2,
            type_name       : v0,
        };
        let v2 = FlashLoanBorrowed{
            pool_id         : arg1,
            borrow_quantity : arg2,
            type_name       : v0,
        };
        0x2::event::emit<FlashLoanBorrowed>(v2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.base_balance, arg2), arg3), v1)
    }

    public(friend) fun borrow_flashloan_quote<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashLoan) {
        assert!(arg2 > 0, 3);
        assert!(0x2::balance::value<T1>(&arg0.quote_balance) >= arg2, 2);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = FlashLoan{
            pool_id         : arg1,
            borrow_quantity : arg2,
            type_name       : v0,
        };
        let v2 = FlashLoanBorrowed{
            pool_id         : arg1,
            borrow_quantity : arg2,
            type_name       : v0,
        };
        0x2::event::emit<FlashLoanBorrowed>(v2);
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_balance, arg2), arg3), v1)
    }

    public(friend) fun return_flashloan_base<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: FlashLoan) {
        assert!(arg1 == arg3.pool_id, 4);
        assert!(0x1::type_name::get<T0>() == arg3.type_name, 5);
        assert!(0x2::coin::value<T0>(&arg2) == arg3.borrow_quantity, 6);
        0x2::balance::join<T0>(&mut arg0.base_balance, 0x2::coin::into_balance<T0>(arg2));
        let FlashLoan {
            pool_id         : _,
            borrow_quantity : _,
            type_name       : _,
        } = arg3;
    }

    public(friend) fun return_flashloan_quote<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: FlashLoan) {
        assert!(arg1 == arg3.pool_id, 4);
        assert!(0x1::type_name::get<T1>() == arg3.type_name, 5);
        assert!(0x2::coin::value<T1>(&arg2) == arg3.borrow_quantity, 6);
        0x2::balance::join<T1>(&mut arg0.quote_balance, 0x2::coin::into_balance<T1>(arg2));
        let FlashLoan {
            pool_id         : _,
            borrow_quantity : _,
            type_name       : _,
        } = arg3;
    }

    public(friend) fun settle_balance_manager<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, arg2: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, arg3: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg4: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::validate_proof(arg3, arg4);
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::base(&arg1) > 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::base(&arg2)) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::deposit_with_proof<T0>(arg3, arg4, 0x2::balance::split<T0>(&mut arg0.base_balance, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::base(&arg1) - 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::base(&arg2)));
        };
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::quote(&arg1) > 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::quote(&arg2)) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::deposit_with_proof<T1>(arg3, arg4, 0x2::balance::split<T1>(&mut arg0.quote_balance, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::quote(&arg1) - 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::quote(&arg2)));
        };
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::deep(&arg1) > 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::deep(&arg2)) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::deposit_with_proof<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg4, 0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_balance, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::deep(&arg1) - 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::deep(&arg2)));
        };
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::base(&arg2) > 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::base(&arg1)) {
            0x2::balance::join<T0>(&mut arg0.base_balance, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::withdraw_with_proof<T0>(arg3, arg4, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::base(&arg2) - 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::base(&arg1), false));
        };
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::quote(&arg2) > 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::quote(&arg1)) {
            0x2::balance::join<T1>(&mut arg0.quote_balance, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::withdraw_with_proof<T1>(arg3, arg4, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::quote(&arg2) - 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::quote(&arg1), false));
        };
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::deep(&arg2) > 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::deep(&arg1)) {
            0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_balance, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::withdraw_with_proof<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg4, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::deep(&arg2) - 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::deep(&arg1), false));
        };
    }

    public(friend) fun withdraw_deep_to_burn<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_balance, arg1)
    }

    // decompiled from Move bytecode v6
}

