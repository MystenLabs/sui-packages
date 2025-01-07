module 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::margin_bank {
    struct BankBalanceUpdate has copy, drop {
        action: u64,
        srcAddress: address,
        destAddress: address,
        amount: u128,
        srcBalance: u128,
        destBalance: u128,
    }

    struct WithdrawalStatusUpdate has copy, drop {
        status: bool,
    }

    struct BankAccount has store {
        balance: u128,
        owner: address,
    }

    struct Bank<phantom T0> has store, key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, BankAccount>,
        coinBalance: 0x2::balance::Balance<T0>,
        isWithdrawalAllowed: bool,
        supportedCoin: 0x1::string::String,
    }

    public entry fun create_bank<T0>(arg0: &0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::roles::ExchangeAdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank<T0>{
            id                  : 0x2::object::new(arg2),
            accounts            : 0x2::table::new<address, BankAccount>(arg2),
            coinBalance         : 0x2::balance::zero<T0>(),
            isWithdrawalAllowed : true,
            supportedCoin       : arg1,
        };
        0x2::transfer::share_object<Bank<T0>>(v0);
    }

    entry fun deposit_to_bank<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = &mut arg0.accounts;
        initialize_account(v1, arg1);
        initialize_account(v1, v0);
        assert!(arg2 <= 0x2::coin::value<T0>(arg3), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::coin_does_not_have_enough_amount());
        0x2::coin::put<T0>(&mut arg0.coinBalance, 0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg3), arg2, arg4));
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, arg1).balance;
        let v3 = 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::convert_usdc_to_base_decimals((arg2 as u128));
        *v2 = v3 + *v2;
        let v4 = BankBalanceUpdate{
            action      : 0,
            srcAddress  : v0,
            destAddress : arg1,
            amount      : v3,
            srcBalance  : 0x2::table::borrow<address, BankAccount>(v1, v0).balance,
            destBalance : 0x2::table::borrow<address, BankAccount>(v1, arg1).balance,
        };
        0x2::event::emit<BankBalanceUpdate>(v4);
    }

    public fun get_balance<T0>(arg0: &Bank<T0>, arg1: address) : u128 {
        let v0 = &arg0.accounts;
        if (!0x2::table::contains<address, BankAccount>(v0, arg1)) {
            return 0
        };
        0x2::table::borrow<address, BankAccount>(v0, arg1).balance
    }

    public(friend) fun initialize_account(arg0: &mut 0x2::table::Table<address, BankAccount>, arg1: address) {
        if (!0x2::table::contains<address, BankAccount>(arg0, arg1)) {
            let v0 = BankAccount{
                balance : 0,
                owner   : arg1,
            };
            0x2::table::add<address, BankAccount>(arg0, arg1, v0);
        };
    }

    public fun is_withdrawal_allowed<T0>(arg0: &Bank<T0>) : bool {
        arg0.isWithdrawalAllowed
    }

    public(friend) fun mut_accounts<T0>(arg0: &mut Bank<T0>) : &mut 0x2::table::Table<address, BankAccount> {
        &mut arg0.accounts
    }

    public entry fun set_withdrawal_status<T0>(arg0: &0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::roles::CapabilitiesSafe, arg1: &0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::roles::ExchangeGuardianCap, arg2: &mut Bank<T0>, arg3: bool) {
        0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::roles::check_guardian_validity(arg0, arg1);
        arg2.isWithdrawalAllowed = arg3;
        let v0 = WithdrawalStatusUpdate{status: arg3};
        0x2::event::emit<WithdrawalStatusUpdate>(v0);
    }

    fun transfer_based_on_fundsflow<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::Number, arg4: u64) {
        if (0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::value(arg3) == 0) {
            return
        };
        let (v0, v1, v2) = if (0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::gt_uint(arg3, 0)) {
            (arg1, arg4, arg2)
        } else {
            (arg2, 2, arg1)
        };
        transfer_margin_to_account<T0>(arg0, v2, v0, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::value(arg3), v1);
    }

    public(friend) fun transfer_margin_to_account<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: u128, arg4: u64) {
        let v0 = &mut arg0.accounts;
        let v1 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg1).balance;
        assert!(*v1 >= arg3, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::not_enough_balance_in_margin_bank(arg4));
        *v1 = *v1 - arg3;
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg2).balance;
        *v2 = *v2 + (arg3 as u128);
        let v3 = BankBalanceUpdate{
            action      : 2,
            srcAddress  : arg1,
            destAddress : arg2,
            amount      : arg3,
            srcBalance  : 0x2::table::borrow<address, BankAccount>(v0, arg1).balance,
            destBalance : 0x2::table::borrow<address, BankAccount>(v0, arg2).balance,
        };
        0x2::event::emit<BankBalanceUpdate>(v3);
    }

    public(friend) fun transfer_trade_margin<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: address, arg4: 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::Number, arg5: 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::Number) {
        assert!(0x2::table::contains<address, BankAccount>(&arg0.accounts, arg2), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::not_enough_balance_in_margin_bank(0));
        assert!(0x2::table::contains<address, BankAccount>(&arg0.accounts, arg3), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::not_enough_balance_in_margin_bank(1));
        if (0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::gte_uint(arg4, 0)) {
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg2, arg4, 0);
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg3, arg5, 1);
        } else {
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg3, arg5, 1);
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg2, arg4, 0);
        };
    }

    entry fun withdraw_all_margin_from_bank<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.isWithdrawalAllowed, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::withdrawal_is_not_allowed());
        let v1 = &mut arg0.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v1, v0), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::user_has_no_bank_account());
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, v0).balance;
        if (*v2 == 0) {
            return
        };
        let v3 = *v2 / 1000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coinBalance, (v3 as u64), arg2), arg1);
        *v2 = 0;
        let v4 = BankBalanceUpdate{
            action      : 1,
            srcAddress  : v0,
            destAddress : arg1,
            amount      : v3 * 1000,
            srcBalance  : 0x2::table::borrow<address, BankAccount>(v1, v0).balance,
            destBalance : 0x2::table::borrow<address, BankAccount>(v1, arg1).balance,
        };
        0x2::event::emit<BankBalanceUpdate>(v4);
    }

    entry fun withdraw_from_bank<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.isWithdrawalAllowed, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::withdrawal_is_not_allowed());
        let v1 = &mut arg0.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v1, v0), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::user_has_no_bank_account());
        let v2 = 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::convert_usdc_to_base_decimals(arg2);
        let v3 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, v0).balance;
        assert!(*v3 >= v2, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::not_enough_balance_in_margin_bank(3));
        *v3 = *v3 - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coinBalance, (arg2 as u64), arg3), arg1);
        let v4 = BankBalanceUpdate{
            action      : 1,
            srcAddress  : v0,
            destAddress : arg1,
            amount      : v2,
            srcBalance  : 0x2::table::borrow<address, BankAccount>(v1, v0).balance,
            destBalance : 0x2::table::borrow<address, BankAccount>(v1, arg1).balance,
        };
        0x2::event::emit<BankBalanceUpdate>(v4);
    }

    // decompiled from Move bytecode v6
}

