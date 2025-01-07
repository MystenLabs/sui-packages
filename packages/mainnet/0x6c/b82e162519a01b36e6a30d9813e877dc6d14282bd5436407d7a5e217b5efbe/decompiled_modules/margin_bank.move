module 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank {
    struct BankBalanceUpdate has copy, drop {
        action: u64,
        srcAddress: address,
        destAddress: address,
        amount: u128,
        srcBalance: u128,
        destBalance: u128,
    }

    struct BankBalanceUpdateV2 has copy, drop {
        tx_index: u128,
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

    struct BankV2<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        accounts: 0x2::table::Table<address, BankAccount>,
        coinBalance: 0x2::balance::Balance<T0>,
        isWithdrawalAllowed: bool,
        supportedCoin: 0x1::string::String,
    }

    public entry fun create_bank<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BankV2<T0>{
            id                  : 0x2::object::new(arg2),
            version             : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(),
            accounts            : 0x2::table::new<address, BankAccount>(arg2),
            coinBalance         : 0x2::balance::zero<T0>(),
            isWithdrawalAllowed : true,
            supportedCoin       : arg1,
        };
        0x2::transfer::share_object<BankV2<T0>>(v0);
    }

    entry fun deposit_to_bank<T0>(arg0: &mut BankV2<T0>, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg2: vector<u8>, arg3: address, arg4: u64, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = &mut arg0.accounts;
        initialize_account(v1, arg3);
        initialize_account(v1, v0);
        assert!(arg4 <= 0x2::coin::value<T0>(arg5), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::coin_does_not_have_enough_amount());
        0x2::coin::put<T0>(&mut arg0.coinBalance, 0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg5), arg4, arg6));
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, arg3).balance;
        let v3 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::convert_usdc_to_base_decimals((arg4 as u128));
        *v2 = v3 + *v2;
        let v4 = BankBalanceUpdateV2{
            tx_index    : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_unique_tx(arg1, arg2),
            action      : 0,
            srcAddress  : v0,
            destAddress : arg3,
            amount      : v3,
            srcBalance  : 0x2::table::borrow<address, BankAccount>(v1, v0).balance,
            destBalance : 0x2::table::borrow<address, BankAccount>(v1, arg3).balance,
        };
        0x2::event::emit<BankBalanceUpdateV2>(v4);
    }

    public fun get_balance<T0>(arg0: &Bank<T0>, arg1: address) : u128 {
        let v0 = &arg0.accounts;
        if (!0x2::table::contains<address, BankAccount>(v0, arg1)) {
            return 0
        };
        0x2::table::borrow<address, BankAccount>(v0, arg1).balance
    }

    public fun get_balance_v2<T0>(arg0: &BankV2<T0>, arg1: address) : u128 {
        let v0 = &arg0.accounts;
        if (!0x2::table::contains<address, BankAccount>(v0, arg1)) {
            return 0
        };
        0x2::table::borrow<address, BankAccount>(v0, arg1).balance
    }

    public fun get_version<T0>(arg0: &BankV2<T0>) : u64 {
        arg0.version
    }

    entry fun increment_bank_version<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut BankV2<T0>) {
        arg1.version = arg1.version + 1;
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

    public fun is_withdrawal_allowed_v2<T0>(arg0: &BankV2<T0>) : bool {
        arg0.isWithdrawalAllowed
    }

    entry fun migrate_bank<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Bank<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BankV2<T0>{
            id                  : 0x2::object::new(arg3),
            version             : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(),
            accounts            : 0x2::table::new<address, BankAccount>(arg3),
            coinBalance         : 0x2::balance::zero<T0>(),
            isWithdrawalAllowed : true,
            supportedCoin       : arg1.supportedCoin,
        };
        0x2::coin::put<T0>(&mut v0.coinBalance, 0x2::coin::take<T0>(&mut arg1.coinBalance, 0x2::balance::value<T0>(&arg1.coinBalance), arg3));
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = 0x2::table::borrow<address, BankAccount>(&arg1.accounts, v2);
            let v4 = BankAccount{
                balance : v3.balance,
                owner   : v3.owner,
            };
            0x2::table::add<address, BankAccount>(&mut v0.accounts, v2, v4);
            v1 = v1 + 1;
        };
        arg1.isWithdrawalAllowed = false;
        0x2::transfer::share_object<BankV2<T0>>(v0);
    }

    entry fun migrate_bank_v2<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Bank<T0>, arg2: &mut BankV2<T0>, arg3: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            let v2 = 0x2::table::borrow<address, BankAccount>(&arg1.accounts, v1);
            let v3 = BankAccount{
                balance : v2.balance,
                owner   : v2.owner,
            };
            0x2::table::add<address, BankAccount>(&mut arg2.accounts, v1, v3);
            v0 = v0 + 1;
        };
    }

    public(friend) fun mut_accounts<T0>(arg0: &mut Bank<T0>) : &mut 0x2::table::Table<address, BankAccount> {
        &mut arg0.accounts
    }

    public(friend) fun mut_accounts_v2<T0>(arg0: &mut BankV2<T0>) : &mut 0x2::table::Table<address, BankAccount> {
        &mut arg0.accounts
    }

    public entry fun set_withdrawal_status<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafe, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeGuardianCap, arg2: &mut Bank<T0>, arg3: bool) {
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::check_guardian_validity(arg0, arg1);
        arg2.isWithdrawalAllowed = arg3;
        let v0 = WithdrawalStatusUpdate{status: arg3};
        0x2::event::emit<WithdrawalStatusUpdate>(v0);
    }

    public entry fun set_withdrawal_status_v2<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafeV2, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeGuardianCap, arg2: &mut BankV2<T0>, arg3: bool) {
        assert!(arg2.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_safe_version(arg0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::check_guardian_validity_v2(arg0, arg1);
        arg2.isWithdrawalAllowed = arg3;
        let v0 = WithdrawalStatusUpdate{status: arg3};
        0x2::event::emit<WithdrawalStatusUpdate>(v0);
    }

    fun transfer_based_on_fundsflow<T0>(arg0: &mut BankV2<T0>, arg1: address, arg2: address, arg3: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::Number, arg4: u64, arg5: u128) {
        if (0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::value(arg3) == 0) {
            return
        };
        let (v0, v1, v2) = if (0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::gt_uint(arg3, 0)) {
            (arg1, arg4, arg2)
        } else {
            (arg2, 2, arg1)
        };
        transfer_margin_to_account_v2<T0>(arg0, v2, v0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::value(arg3), v1, arg5);
    }

    public(friend) fun transfer_margin_to_account<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: u128, arg4: u64) {
        let v0 = &mut arg0.accounts;
        let v1 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg1).balance;
        assert!(*v1 >= arg3, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::not_enough_balance_in_margin_bank(arg4));
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

    public(friend) fun transfer_margin_to_account_v2<T0>(arg0: &mut BankV2<T0>, arg1: address, arg2: address, arg3: u128, arg4: u64, arg5: u128) {
        let v0 = &mut arg0.accounts;
        let v1 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg1).balance;
        assert!(*v1 >= arg3, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::not_enough_balance_in_margin_bank(arg4));
        *v1 = *v1 - arg3;
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg2).balance;
        *v2 = *v2 + (arg3 as u128);
        let v3 = BankBalanceUpdateV2{
            tx_index    : arg5,
            action      : 2,
            srcAddress  : arg1,
            destAddress : arg2,
            amount      : arg3,
            srcBalance  : 0x2::table::borrow<address, BankAccount>(v0, arg1).balance,
            destBalance : 0x2::table::borrow<address, BankAccount>(v0, arg2).balance,
        };
        0x2::event::emit<BankBalanceUpdateV2>(v3);
    }

    public(friend) fun transfer_trade_margin<T0>(arg0: &mut BankV2<T0>, arg1: address, arg2: address, arg3: address, arg4: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::Number, arg5: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::Number, arg6: u128) {
        assert!(0x2::table::contains<address, BankAccount>(&arg0.accounts, arg2), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::not_enough_balance_in_margin_bank(0));
        assert!(0x2::table::contains<address, BankAccount>(&arg0.accounts, arg3), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::not_enough_balance_in_margin_bank(1));
        if (0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::gte_uint(arg4, 0)) {
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg2, arg4, 0, arg6);
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg3, arg5, 1, arg6);
        } else {
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg3, arg5, 1, arg6);
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg2, arg4, 0, arg6);
        };
    }

    entry fun withdraw_all_margin_from_bank<T0>(arg0: &mut BankV2<T0>, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.isWithdrawalAllowed, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::withdrawal_is_not_allowed());
        let v1 = &mut arg0.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v1, v0), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::user_has_no_bank_account());
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, v0).balance;
        if (*v2 == 0) {
            return
        };
        let v3 = *v2 / 1000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coinBalance, (v3 as u64), arg4), arg3);
        *v2 = 0;
        let v4 = BankBalanceUpdateV2{
            tx_index    : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_unique_tx(arg1, arg2),
            action      : 1,
            srcAddress  : v0,
            destAddress : arg3,
            amount      : v3 * 1000,
            srcBalance  : 0x2::table::borrow<address, BankAccount>(v1, v0).balance,
            destBalance : 0x2::table::borrow<address, BankAccount>(v1, arg3).balance,
        };
        0x2::event::emit<BankBalanceUpdateV2>(v4);
    }

    entry fun withdraw_from_bank<T0>(arg0: &mut BankV2<T0>, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg2: vector<u8>, arg3: address, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.isWithdrawalAllowed, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::withdrawal_is_not_allowed());
        let v1 = &mut arg0.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v1, v0), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::user_has_no_bank_account());
        let v2 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::convert_usdc_to_base_decimals(arg4);
        let v3 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, v0).balance;
        assert!(*v3 >= v2, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::not_enough_balance_in_margin_bank(3));
        *v3 = *v3 - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coinBalance, (arg4 as u64), arg5), arg3);
        let v4 = BankBalanceUpdateV2{
            tx_index    : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_unique_tx(arg1, arg2),
            action      : 1,
            srcAddress  : v0,
            destAddress : arg3,
            amount      : v2,
            srcBalance  : 0x2::table::borrow<address, BankAccount>(v1, v0).balance,
            destBalance : 0x2::table::borrow<address, BankAccount>(v1, arg3).balance,
        };
        0x2::event::emit<BankBalanceUpdateV2>(v4);
    }

    // decompiled from Move bytecode v6
}

