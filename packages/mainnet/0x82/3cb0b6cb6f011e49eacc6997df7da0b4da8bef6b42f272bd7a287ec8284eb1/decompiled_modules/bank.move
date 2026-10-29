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

    struct TrialFundLockUpdateEvent has copy, drop {
        tx_index: u128,
        action: u64,
        account: address,
        amount: u128,
        locked_amount: u128,
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

    entry fun decrease_trial_fund_lock<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: address, arg4: u128, arg5: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_trial_fund_operator_validity(arg0, 0x2::tx_context::sender(arg5));
        decrease_trial_fund_lock_internal<T0>(arg1, arg3, arg4, 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg2));
    }

    fun decrease_trial_fund_lock_internal<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: u128, arg3: u64, arg4: u128) {
        assert!(arg2 > 0, 610);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::convert_usdc_to_base_decimals(arg2);
        let v1 = get_trial_fund_locked<T0>(arg0, arg1);
        assert!(v0 <= v1, 609);
        let v2 = v1 - v0;
        if (v2 == 0) {
            0x2::table::remove<address, u128>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<address, u128>>(&mut arg0.id, b"trial_fund_locks"), arg1);
        } else {
            *0x2::table::borrow_mut<address, u128>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<address, u128>>(&mut arg0.id, b"trial_fund_locks"), arg1) = v2;
        };
        let v3 = TrialFundLockUpdateEvent{
            tx_index      : arg4,
            action        : arg3,
            account       : arg1,
            amount        : v0,
            locked_amount : v2,
        };
        0x2::event::emit<TrialFundLockUpdateEvent>(v3);
    }

    fun deposit_from_coin<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 105);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(arg2 > 0, 1000);
        assert!(arg2 <= v0, 107);
        deposit_with_source<T0>(arg0, 0x2::tx_context::sender(arg5), arg1, 0x2::coin::split<T0>(&mut arg3, arg2, arg5), arg4);
        if (arg2 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
    }

    entry fun deposit_trial_fund<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg2);
        deposit_from_coin<T0>(arg1, arg3, arg4, arg5, v0, arg6);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::convert_usdc_to_base_decimals((arg4 as u128));
        if (!0x2::dynamic_field::exists<vector<u8>>(&arg1.id, b"trial_fund_locks")) {
            0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<address, u128>>(&mut arg1.id, b"trial_fund_locks", 0x2::table::new<address, u128>(arg6));
        };
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<address, u128>>(&mut arg1.id, b"trial_fund_locks");
        if (!0x2::table::contains<address, u128>(v2, arg3)) {
            0x2::table::add<address, u128>(v2, arg3, 0);
        };
        let v3 = 0x2::table::borrow_mut<address, u128>(v2, arg3);
        *v3 = *v3 + v1;
        let v4 = TrialFundLockUpdateEvent{
            tx_index      : v0,
            action        : 0,
            account       : arg3,
            amount        : v1,
            locked_amount : *v3,
        };
        0x2::event::emit<TrialFundLockUpdateEvent>(v4);
    }

    entry fun deposit_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        deposit_from_coin<T0>(arg1, arg3, arg4, arg5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg2), arg6);
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
        let v3 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::convert_usdc_to_base_decimals((v1 as u128));
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

    public fun get_trial_fund_locked<T0>(arg0: &Bank<T0>, arg1: address) : u128 {
        if (!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"trial_fund_locks")) {
            return 0
        };
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, 0x2::table::Table<address, u128>>(&arg0.id, b"trial_fund_locks");
        if (!0x2::table::contains<address, u128>(v0, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u128>(v0, arg1)
    }

    public(friend) fun move_balance<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: u128) {
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
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::gas_relayer(arg1);
        if (v0 != arg4) {
            move_balance<T0>(arg2, v0, arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg3));
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

    public(friend) fun withdraw_all_internal<T0>(arg0: &mut Bank<T0>, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        withdraw_with_tx_index<T0>(arg0, arg2, arg3, 0, true, true, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg1), arg4)
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
        withdraw_with_tx_index<T0>(arg0, arg1, arg2, arg3, false, true, arg4, arg5)
    }

    entry fun withdraw_trial_fund<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: address, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_trial_fund_operator_validity(arg0, v0);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg2);
        decrease_trial_fund_lock_internal<T0>(arg1, arg3, arg4, 2, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_with_tx_index<T0>(arg1, arg3, v0, arg4, false, false, v1, arg5), v0);
    }

    entry fun withdraw_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg3: address, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_internal<T0>(arg1, arg2, v0, arg3, arg4, arg5), arg3);
    }

    fun withdraw_with_tx_index<T0>(arg0: &mut Bank<T0>, arg1: address, arg2: address, arg3: u128, arg4: bool, arg5: bool, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (arg5) {
            get_trial_fund_locked<T0>(arg0, arg1)
        } else {
            0
        };
        assert!(arg2 != @0x0, 105);
        assert!(arg0.is_withdrawal_allowed, 604);
        let v1 = &mut arg0.accounts;
        assert!(0x2::table::contains<address, BankAccount>(v1, arg1), 605);
        let v2 = 0x2::table::borrow<address, BankAccount>(v1, arg1).balance;
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        let (v4, v5) = if (arg4) {
            let v6 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::convert_base_decimals_to_usdc(v3);
            assert!(v6 > 0, 1001);
            ((v6 as u64), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::convert_usdc_to_base_decimals(v6))
        } else {
            assert!(arg3 > 0, 1001);
            let v7 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::convert_usdc_to_base_decimals(arg3);
            assert!(v2 >= v7, 603);
            assert!(v3 >= v7, 608);
            ((arg3 as u64), v7)
        };
        let v8 = if (0x2::table::contains<address, BankAccount>(v1, arg2)) {
            0x2::table::borrow<address, BankAccount>(v1, arg2).balance
        } else {
            0
        };
        let v9 = &mut 0x2::table::borrow_mut<address, BankAccount>(v1, arg1).balance;
        assert!(*v9 >= v5, 603);
        *v9 = *v9 - v5;
        let v10 = BankBalanceUpdateEvent{
            tx_index     : arg6,
            action       : 1,
            src_address  : arg1,
            dest_address : arg2,
            amount       : v5,
            src_balance  : *v9,
            dest_balance : v8,
        };
        0x2::event::emit<BankBalanceUpdateEvent>(v10);
        0x2::coin::take<T0>(&mut arg0.coin_balance, v4, arg7)
    }

    // decompiled from Move bytecode v7
}

