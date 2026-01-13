module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank {
    struct BankBalanceUpdateEvent has copy, drop {
        tx_index: u128,
        action: u64,
        src_address: address,
        dest_address: address,
        amount: u128,
        src_balance: u128,
        dest_balance: u128,
    }

    struct WithdrawalStatusUpdateEvent has copy, drop {
        status: bool,
    }

    struct BankAccount has store {
        balance: u128,
        owner: address,
    }

    struct Bank<phantom T0> has store, key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, BankAccount>,
        coin_balance: 0x2::balance::Balance<T0>,
        is_withdrawal_allowed: bool,
        supported_coin: 0x1::string::String,
    }

    public(friend) fun transfer<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: u128, arg4: u64, arg5: u128) {
        let v0 = &mut arg0.accounts;
        let v1 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg1).balance;
        assert!(*v1 >= arg3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::not_enough_balance_in_bank(arg4));
        *v1 = *v1 - arg3;
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg2).balance;
        *v2 = *v2 + (arg3 as u128);
        let v3 = BankBalanceUpdateEvent{
            tx_index     : arg5,
            action       : 2,
            src_address  : arg1,
            dest_address : arg2,
            amount       : arg3,
            src_balance  : 0x2::table::borrow<address, BankAccount>(v0, arg1).balance,
            dest_balance : 0x2::table::borrow<address, BankAccount>(v0, arg2).balance,
        };
        0x2::event::emit<BankBalanceUpdateEvent>(v3);
    }

    public(friend) fun create_account_if_not_exist<T0>(arg0: &mut Bank<T0>, arg1: address) {
        let v0 = &mut arg0.accounts;
        if (!0x2::table::contains<address, BankAccount>(v0, arg1)) {
            let v1 = BankAccount{
                balance : 0,
                owner   : arg1,
            };
            0x2::table::add<address, BankAccount>(v0, arg1, v1);
        };
    }

    entry fun create_bank<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        let v0 = Bank<T0>{
            id                    : 0x2::object::new(arg3),
            accounts              : 0x2::table::new<address, BankAccount>(arg3),
            coin_balance          : 0x2::balance::zero<T0>(),
            is_withdrawal_allowed : true,
            supported_coin        : arg2,
        };
        0x2::transfer::share_object<Bank<T0>>(v0);
    }

    entry fun deposit<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: vector<u8>, arg4: address, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg4 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        let v0 = 0x2::coin::value<T0>(&arg6);
        assert!(arg5 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::deposit_amount_must_be_greater_than_zero());
        assert!(arg5 <= v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::coin_does_not_have_enough_amount());
        deposit_internal<T0>(arg1, arg4, 0x2::coin::split<T0>(&mut arg6, arg5, arg7), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg2, arg3), arg7);
        if (arg5 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
        };
    }

    public(friend) fun deposit_internal<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        create_account_if_not_exist<T0>(arg0, arg1);
        create_account_if_not_exist<T0>(arg0, v0);
        let v1 = &mut arg0.accounts;
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::deposit_amount_must_be_greater_than_zero());
        0x2::coin::put<T0>(&mut arg0.coin_balance, arg2);
        let v3 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, arg1).balance;
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::convert_usdc_to_base_decimals((v2 as u128));
        *v3 = v4 + *v3;
        let v5 = BankBalanceUpdateEvent{
            tx_index     : arg3,
            action       : 0,
            src_address  : v0,
            dest_address : arg1,
            amount       : v4,
            src_balance  : 0x2::table::borrow<address, BankAccount>(v1, v0).balance,
            dest_balance : 0x2::table::borrow<address, BankAccount>(v1, arg1).balance,
        };
        0x2::event::emit<BankBalanceUpdateEvent>(v5);
    }

    public(friend) fun exists_account<T0>(arg0: &Bank<T0>, arg1: address) : bool {
        0x2::table::contains<address, BankAccount>(&arg0.accounts, arg1)
    }

    public(friend) fun get_balance<T0>(arg0: &Bank<T0>, arg1: address) : u128 {
        let v0 = &arg0.accounts;
        if (!0x2::table::contains<address, BankAccount>(v0, arg1)) {
            return 0
        };
        0x2::table::borrow<address, BankAccount>(v0, arg1).balance
    }

    public(friend) fun get_bank_id<T0>(arg0: &Bank<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun is_withdrawal_allowed<T0>(arg0: &Bank<T0>) : bool {
        arg0.is_withdrawal_allowed
    }

    public fun remove_empty_account<T0>(arg0: &mut Bank<T0>, arg1: address) {
        let v0 = &mut arg0.accounts;
        if (0x2::table::contains<address, BankAccount>(v0, arg1)) {
            let BankAccount {
                balance : v1,
                owner   : _,
            } = 0x2::table::remove<address, BankAccount>(v0, arg1);
            assert!(v1 == 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::bank_account_has_balance());
        };
    }

    public fun set_withdrawal_status<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Bank<T0>, arg3: bool) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        arg2.is_withdrawal_allowed = arg3;
        let v0 = WithdrawalStatusUpdateEvent{status: arg3};
        0x2::event::emit<WithdrawalStatusUpdateEvent>(v0);
    }

    entry fun withdraw<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: vector<u8>, arg4: address, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_internal<T0>(arg1, arg2, arg3, v0, arg4, arg5, arg6), arg4);
    }

    entry fun withdraw_all<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg4 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1.is_withdrawal_allowed, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::withdrawal_is_not_allowed());
        let v1 = &mut arg1.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v1, v0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::user_has_no_bank_account());
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, v0).balance;
        if (*v2 == 0) {
            return
        };
        let v3 = *v2 / 1000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.coin_balance, (v3 as u64), arg5), arg4);
        *v2 = 0;
        let v4 = BankBalanceUpdateEvent{
            tx_index     : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg2, arg3),
            action       : 1,
            src_address  : v0,
            dest_address : arg4,
            amount       : v3 * 1000,
            src_balance  : 0x2::table::borrow<address, BankAccount>(v1, v0).balance,
            dest_balance : 0x2::table::borrow<address, BankAccount>(v1, arg4).balance,
        };
        0x2::event::emit<BankBalanceUpdateEvent>(v4);
    }

    public(friend) fun withdraw_internal<T0>(arg0: &mut Bank<T0>, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg2: vector<u8>, arg3: address, arg4: address, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg4 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(arg0.is_withdrawal_allowed, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::withdrawal_is_not_allowed());
        let v0 = &mut arg0.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v0, arg3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::user_has_no_bank_account());
        assert!(arg5 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::withdraw_amount_must_be_greater_than_zero());
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::convert_usdc_to_base_decimals(arg5);
        let v2 = if (0x2::table::contains<address, BankAccount>(v0, arg4)) {
            0x2::table::borrow<address, BankAccount>(v0, arg4).balance
        } else {
            0
        };
        let v3 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg3).balance;
        assert!(*v3 >= v1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::not_enough_balance_in_bank(3));
        *v3 = *v3 - v1;
        let v4 = BankBalanceUpdateEvent{
            tx_index     : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg1, arg2),
            action       : 1,
            src_address  : arg3,
            dest_address : arg4,
            amount       : v1,
            src_balance  : *v3,
            dest_balance : v2,
        };
        0x2::event::emit<BankBalanceUpdateEvent>(v4);
        0x2::coin::take<T0>(&mut arg0.coin_balance, (arg5 as u64), arg6)
    }

    // decompiled from Move bytecode v6
}

