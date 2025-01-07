module 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::margin_bank {
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

    struct Bank has store, key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, BankAccount>,
        coinBalance: 0x2::balance::Balance<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>,
        isWithdrawalAllowed: bool,
    }

    entry fun deposit_to_bank(arg0: &mut Bank, arg1: address, arg2: u64, arg3: &mut 0x2::coin::Coin<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = &mut arg0.accounts;
        initialize_account(v1, arg1);
        initialize_account(v1, v0);
        assert!(arg2 <= 0x2::coin::value<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>(arg3), 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::error::coin_does_not_have_enough_amount());
        0x2::coin::put<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>(&mut arg0.coinBalance, 0x2::coin::take<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>(0x2::coin::balance_mut<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>(arg3), arg2, arg4));
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, arg1).balance;
        let v3 = 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::convert_usdc_to_base_decimals((arg2 as u128));
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

    public fun get_balance(arg0: &Bank, arg1: address) : u128 {
        let v0 = &arg0.accounts;
        if (!0x2::table::contains<address, BankAccount>(v0, arg1)) {
            return 0
        };
        0x2::table::borrow<address, BankAccount>(v0, arg1).balance
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id                  : 0x2::object::new(arg0),
            accounts            : 0x2::table::new<address, BankAccount>(arg0),
            coinBalance         : 0x2::balance::zero<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>(),
            isWithdrawalAllowed : true,
        };
        0x2::transfer::share_object<Bank>(v0);
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

    public fun is_withdrawal_allowed(arg0: &Bank) : bool {
        arg0.isWithdrawalAllowed
    }

    public(friend) fun mut_accounts(arg0: &mut Bank) : &mut 0x2::table::Table<address, BankAccount> {
        &mut arg0.accounts
    }

    public entry fun set_withdrawal_status(arg0: &0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::roles::CapabilitiesSafe, arg1: &0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::roles::ExchangeGuardianCap, arg2: &mut Bank, arg3: bool) {
        0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::roles::check_guardian_validity(arg0, arg1);
        arg2.isWithdrawalAllowed = arg3;
        let v0 = WithdrawalStatusUpdate{status: arg3};
        0x2::event::emit<WithdrawalStatusUpdate>(v0);
    }

    fun transfer_based_on_fundsflow(arg0: &mut Bank, arg1: address, arg2: address, arg3: 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::signed_number::Number, arg4: u64) {
        if (0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::signed_number::value(arg3) == 0) {
            return
        };
        let (v0, v1, v2) = if (0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::signed_number::gt_uint(arg3, 0)) {
            (arg1, arg4, arg2)
        } else {
            (arg2, 2, arg1)
        };
        transfer_margin_to_account(arg0, v2, v0, 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::signed_number::value(arg3), v1);
    }

    public(friend) fun transfer_margin_to_account(arg0: &mut Bank, arg1: address, arg2: address, arg3: u128, arg4: u64) {
        let v0 = &mut arg0.accounts;
        let v1 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg1).balance;
        assert!(*v1 >= arg3, 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::error::not_enough_balance_in_margin_bank(arg4));
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

    public(friend) fun transfer_trade_margin(arg0: &mut Bank, arg1: address, arg2: address, arg3: address, arg4: 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::signed_number::Number, arg5: 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::signed_number::Number) {
        assert!(0x2::table::contains<address, BankAccount>(&arg0.accounts, arg2), 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::error::not_enough_balance_in_margin_bank(0));
        assert!(0x2::table::contains<address, BankAccount>(&arg0.accounts, arg3), 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::error::not_enough_balance_in_margin_bank(1));
        if (0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::signed_number::gte_uint(arg4, 0)) {
            transfer_based_on_fundsflow(arg0, arg1, arg2, arg4, 0);
            transfer_based_on_fundsflow(arg0, arg1, arg3, arg5, 1);
        } else {
            transfer_based_on_fundsflow(arg0, arg1, arg3, arg5, 1);
            transfer_based_on_fundsflow(arg0, arg1, arg2, arg4, 0);
        };
    }

    entry fun withdraw_all_margin_from_bank(arg0: &mut Bank, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.isWithdrawalAllowed, 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::error::withdrawal_is_not_allowed());
        let v1 = &mut arg0.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v1, v0), 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::error::user_has_no_bank_account());
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, v0).balance;
        if (*v2 == 0) {
            return
        };
        let v3 = *v2 / 1000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>>(0x2::coin::take<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>(&mut arg0.coinBalance, (v3 as u64), arg2), arg1);
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

    entry fun withdraw_from_bank(arg0: &mut Bank, arg1: address, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.isWithdrawalAllowed, 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::error::withdrawal_is_not_allowed());
        let v1 = &mut arg0.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v1, v0), 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::error::user_has_no_bank_account());
        let v2 = 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::convert_usdc_to_base_decimals(arg2);
        let v3 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, v0).balance;
        assert!(*v3 >= v2, 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::error::not_enough_balance_in_margin_bank(3));
        *v3 = *v3 - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>>(0x2::coin::take<0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::tusdc::TUSDC>(&mut arg0.coinBalance, (arg2 as u64), arg3), arg1);
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

