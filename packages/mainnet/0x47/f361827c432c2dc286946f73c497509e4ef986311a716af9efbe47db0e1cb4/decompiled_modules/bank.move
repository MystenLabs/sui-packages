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
        transfer_with_action<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 2);
    }

    public(friend) fun bank_address<T0>(arg0: &Bank<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun charge_relayer_gas_fee<T0>(arg0: &mut Bank<T0>, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address, arg3: 0x1::string::String, arg4: u128, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::get_action_gas_fee(arg1, arg3, arg5);
        if (v0 == 0) {
            return
        };
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::gas_relayer(arg1);
        create_account_if_not_exist<T0>(arg0, v1);
        transfer_gas_fee<T0>(arg0, arg2, v1, v0, 3, arg4);
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
        abort 999
    }

    public(friend) fun deposit_internal<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        deposit_with_source<T0>(arg0, 0x2::tx_context::sender(arg4), arg1, arg2, arg3);
    }

    entry fun deposit_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(arg3 != @0x0, 105);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(arg4 > 0, 1000);
        assert!(arg4 <= v0, 107);
        deposit_internal<T0>(arg1, arg3, 0x2::coin::split<T0>(&mut arg5, arg4, arg6), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg2), arg6);
        if (arg4 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
    }

    public(friend) fun deposit_with_source<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u128) {
        assert!(arg2 != @0x0, 105);
        create_account_if_not_exist<T0>(arg0, arg2);
        create_account_if_not_exist<T0>(arg0, arg1);
        let v0 = &mut arg0.accounts;
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 > 0, 1000);
        0x2::coin::put<T0>(&mut arg0.coin_balance, arg3);
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg2).balance;
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::convert_usdc_to_base_decimals((v1 as u128));
        *v2 = v3 + *v2;
        let v4 = BankBalanceUpdateEvent{
            tx_index     : arg4,
            action       : 0,
            src_address  : arg1,
            dest_address : arg2,
            amount       : v3,
            src_balance  : 0x2::table::borrow<address, BankAccount>(v0, arg1).balance,
            dest_balance : *v2,
        };
        0x2::event::emit<BankBalanceUpdateEvent>(v4);
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

    public(friend) fun migrate_gas_relayer_balance<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: u128) {
        if (arg1 == arg2) {
            return
        };
        create_account_if_not_exist<T0>(arg0, arg2);
        if (!exists_account<T0>(arg0, arg1)) {
            return
        };
        let v0 = get_balance<T0>(arg0, arg1);
        if (v0 > 0) {
            transfer<T0>(arg0, arg1, arg2, v0, 2, arg3);
        };
        remove_empty_account_internal<T0>(arg0, arg1);
    }

    public fun remove_empty_account<T0>(arg0: &mut Bank<T0>, arg1: address) {
        abort 999
    }

    public(friend) fun remove_empty_account_internal<T0>(arg0: &mut Bank<T0>, arg1: address) {
        let v0 = &mut arg0.accounts;
        if (0x2::table::contains<address, BankAccount>(v0, arg1)) {
            let BankAccount {
                balance : v1,
                owner   : _,
            } = 0x2::table::remove<address, BankAccount>(v0, arg1);
            assert!(v1 == 0, 607);
        };
    }

    entry fun set_relayer<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: &mut Bank<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg1, arg0);
        assert!(arg4 != @0x0, 105);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::gas_relayer(arg1);
        if (v0 != arg4) {
            migrate_gas_relayer_balance<T0>(arg2, v0, arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg3));
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::set_gas_relayer(arg0, arg1, arg4);
    }

    public fun set_withdrawal_status<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Bank<T0>, arg3: bool) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        arg2.is_withdrawal_allowed = arg3;
        let v0 = WithdrawalStatusUpdateEvent{status: arg3};
        0x2::event::emit<WithdrawalStatusUpdateEvent>(v0);
    }

    public(friend) fun transfer_gas_fee<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: u128, arg4: u64, arg5: u128) {
        transfer_with_action<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 3);
    }

    fun transfer_with_action<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: u128, arg4: u64, arg5: u128, arg6: u64) {
        let v0 = &mut arg0.accounts;
        let v1 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg1).balance;
        assert!(*v1 >= arg3, 600 + arg4);
        *v1 = *v1 - arg3;
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg2).balance;
        *v2 = *v2 + (arg3 as u128);
        let v3 = BankBalanceUpdateEvent{
            tx_index     : arg5,
            action       : arg6,
            src_address  : arg1,
            dest_address : arg2,
            amount       : arg3,
            src_balance  : 0x2::table::borrow<address, BankAccount>(v0, arg1).balance,
            dest_balance : 0x2::table::borrow<address, BankAccount>(v0, arg2).balance,
        };
        0x2::event::emit<BankBalanceUpdateEvent>(v3);
    }

    entry fun withdraw<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: vector<u8>, arg4: address, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    entry fun withdraw_all<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public(friend) fun withdraw_all_internal<T0>(arg0: &mut Bank<T0>, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg3 != @0x0, 105);
        assert!(arg0.is_withdrawal_allowed, 604);
        let v0 = &mut arg0.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v0, arg2), 605);
        let v1 = if (0x2::table::contains<address, BankAccount>(v0, arg3)) {
            0x2::table::borrow<address, BankAccount>(v0, arg3).balance
        } else {
            0
        };
        let v2 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg2).balance;
        let v3 = *v2 / 1000;
        assert!(v3 > 0, 1001);
        let v4 = v3 * 1000;
        *v2 = *v2 - v4;
        let v5 = BankBalanceUpdateEvent{
            tx_index     : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg1),
            action       : 1,
            src_address  : arg2,
            dest_address : arg3,
            amount       : v4,
            src_balance  : 0x2::table::borrow<address, BankAccount>(v0, arg2).balance,
            dest_balance : v1,
        };
        0x2::event::emit<BankBalanceUpdateEvent>(v5);
        0x2::coin::take<T0>(&mut arg0.coin_balance, (v3 as u64), arg4)
    }

    entry fun withdraw_all_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_all_internal<T0>(arg1, arg2, v0, arg3, arg4), arg3);
    }

    public(friend) fun withdraw_internal<T0>(arg0: &mut Bank<T0>, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg2: address, arg3: address, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        withdraw_internal_with_tx_index<T0>(arg0, arg2, arg3, arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg1), arg5)
    }

    public(friend) fun withdraw_internal_with_tx_index<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: u128, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 != @0x0, 105);
        assert!(arg0.is_withdrawal_allowed, 604);
        let v0 = &mut arg0.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v0, arg1), 605);
        assert!(arg3 > 0, 1001);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::convert_usdc_to_base_decimals(arg3);
        let v2 = if (0x2::table::contains<address, BankAccount>(v0, arg2)) {
            0x2::table::borrow<address, BankAccount>(v0, arg2).balance
        } else {
            0
        };
        let v3 = &mut 0x2::table::borrow_mut<address, BankAccount>(v0, arg1).balance;
        assert!(*v3 >= v1, 603);
        *v3 = *v3 - v1;
        let v4 = BankBalanceUpdateEvent{
            tx_index     : arg4,
            action       : 1,
            src_address  : arg1,
            dest_address : arg2,
            amount       : v1,
            src_balance  : *v3,
            dest_balance : v2,
        };
        0x2::event::emit<BankBalanceUpdateEvent>(v4);
        0x2::coin::take<T0>(&mut arg0.coin_balance, (arg3 as u64), arg5)
    }

    entry fun withdraw_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: address, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_internal<T0>(arg1, arg2, v0, arg3, arg4, arg5), arg3);
    }

    // decompiled from Move bytecode v7
}

