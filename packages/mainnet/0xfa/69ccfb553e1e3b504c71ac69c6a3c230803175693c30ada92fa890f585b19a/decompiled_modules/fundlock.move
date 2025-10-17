module 0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::fundlock {
    struct FUNDLOCK has drop {
        dummy_field: bool,
    }

    struct Withdrawal<phantom T0> has store {
        locked_balance: 0x2::balance::Balance<T0>,
        timestamp_ms: u64,
    }

    struct ClientVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        withdrawals: vector<Withdrawal<T0>>,
    }

    struct FundLock has key {
        id: 0x2::object::UID,
        client_vaults: 0x2::table::Table<address, 0x2::bag::Bag>,
        release_lock_ms: u64,
        trade_lock_ms: u64,
    }

    struct Deposited has copy, drop {
        client: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        balance: u64,
    }

    struct WithdrawalRequested has copy, drop {
        client: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        index: u64,
        timestamp_ms: u64,
        balance: u64,
    }

    struct FundsReleased has copy, drop {
        client: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        index: u64,
        withdrawal_timestamp_ms: u64,
    }

    struct BalanceUpdated has copy, drop {
        client: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        is_deposit: bool,
        backend_id: u64,
        balance: u64,
    }

    struct FundedFromWithdrawal has copy, drop {
        client: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        index: u64,
    }

    struct WithdrawalInfo has copy, drop {
        amount: u64,
        timestamp_ms: u64,
    }

    public fun balance_of<T0>(arg0: &FundLock, arg1: address) : u64 {
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.client_vaults, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.client_vaults, arg1);
        if (!has_vault<T0>(v0)) {
            return 0
        };
        0x2::balance::value<T0>(&get_vault<T0>(v0).balance)
    }

    fun create_vault<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ClientVault<T0>{
            id          : 0x2::object::new(arg2),
            balance     : arg1,
            withdrawals : 0x1::vector::empty<Withdrawal<T0>>(),
        };
        0x2::bag::add<0x1::type_name::TypeName, ClientVault<T0>>(arg0, 0x1::type_name::with_original_ids<T0>(), v0);
    }

    public fun deposit<T0>(arg0: &mut FundLock, arg1: &0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::token_validator::TokenRegistry, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 400);
        0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::token_validator::assert_whitelisted<T0>(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.client_vaults, v1)) {
            0x2::table::add<address, 0x2::bag::Bag>(&mut arg0.client_vaults, v1, 0x2::bag::new(arg3));
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.client_vaults, v1);
        if (has_vault<T0>(v2)) {
            let v3 = get_vault_mut<T0>(v2);
            0x2::balance::join<T0>(&mut v3.balance, 0x2::coin::into_balance<T0>(arg2));
        } else {
            create_vault<T0>(v2, 0x2::coin::into_balance<T0>(arg2), arg3);
        };
        let v4 = Deposited{
            client    : v1,
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            amount    : v0,
            balance   : 0x2::balance::value<T0>(&get_vault<T0>(v2).balance),
        };
        0x2::event::emit<Deposited>(v4);
    }

    fun fund_from_withdrawal<T0>(arg0: &mut ClientVault<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::length<Withdrawal<T0>>(&arg0.withdrawals);
        while (v2 < v3 && v1 < arg2) {
            let v4 = 0x1::vector::borrow<Withdrawal<T0>>(&arg0.withdrawals, v2);
            if (0x2::clock::timestamp_ms(arg4) < v4.timestamp_ms + arg3) {
                let v5 = 0x2::balance::value<T0>(&v4.locked_balance);
                let v6 = arg2 - v1;
                if (v5 <= v6) {
                    let Withdrawal {
                        locked_balance : v7,
                        timestamp_ms   : _,
                    } = 0x1::vector::remove<Withdrawal<T0>>(&mut arg0.withdrawals, v2);
                    v1 = v1 + v5;
                    0x2::balance::join<T0>(&mut v0, v7);
                    let v9 = FundedFromWithdrawal{
                        client    : arg1,
                        coin_type : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
                        amount    : v5,
                        index     : v2,
                    };
                    0x2::event::emit<FundedFromWithdrawal>(v9);
                    v3 = v3 - 1;
                    continue
                };
                v1 = v1 + v6;
                0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(&mut 0x1::vector::borrow_mut<Withdrawal<T0>>(&mut arg0.withdrawals, v2).locked_balance, v6));
                let v10 = FundedFromWithdrawal{
                    client    : arg1,
                    coin_type : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
                    amount    : v6,
                    index     : v2,
                };
                0x2::event::emit<FundedFromWithdrawal>(v10);
                v2 = v2 + 1;
                continue
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun funds_to_withdraw_total<T0>(arg0: &FundLock, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.client_vaults, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.client_vaults, arg1);
        if (!has_vault<T0>(v0)) {
            return 0
        };
        let v1 = get_vault<T0>(v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Withdrawal<T0>>(&v1.withdrawals)) {
            let v4 = 0x1::vector::borrow<Withdrawal<T0>>(&v1.withdrawals, v3);
            if (0x2::clock::timestamp_ms(arg2) < v4.timestamp_ms + arg0.trade_lock_ms) {
                v2 = v2 + 0x2::balance::value<T0>(&v4.locked_balance);
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_active_withdrawals<T0>(arg0: &FundLock, arg1: address) : vector<WithdrawalInfo> {
        let v0 = 0x1::vector::empty<WithdrawalInfo>();
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.client_vaults, arg1)) {
            return v0
        };
        let v1 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.client_vaults, arg1);
        if (!has_vault<T0>(v1)) {
            return v0
        };
        let v2 = get_vault<T0>(v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<Withdrawal<T0>>(&v2.withdrawals)) {
            let v4 = 0x1::vector::borrow<Withdrawal<T0>>(&v2.withdrawals, v3);
            let v5 = WithdrawalInfo{
                amount       : 0x2::balance::value<T0>(&v4.locked_balance),
                timestamp_ms : v4.timestamp_ms,
            };
            0x1::vector::push_back<WithdrawalInfo>(&mut v0, v5);
            v3 = v3 + 1;
        };
        v0
    }

    fun get_vault<T0>(arg0: &0x2::bag::Bag) : &ClientVault<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, ClientVault<T0>>(arg0, 0x1::type_name::with_original_ids<T0>())
    }

    fun get_vault_mut<T0>(arg0: &mut 0x2::bag::Bag) : &mut ClientVault<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, ClientVault<T0>>(arg0, 0x1::type_name::with_original_ids<T0>())
    }

    public fun get_withdrawal<T0>(arg0: &FundLock, arg1: address, arg2: u64) : (u64, u64) {
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(&arg0.client_vaults, arg1), 402);
        let v0 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.client_vaults, arg1);
        assert!(has_vault<T0>(v0), 402);
        let v1 = get_vault<T0>(v0);
        assert!(arg2 < 0x1::vector::length<Withdrawal<T0>>(&v1.withdrawals), 405);
        let v2 = 0x1::vector::borrow<Withdrawal<T0>>(&v1.withdrawals, arg2);
        (0x2::balance::value<T0>(&v2.locked_balance), v2.timestamp_ms)
    }

    fun has_vault<T0>(arg0: &0x2::bag::Bag) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(arg0, 0x1::type_name::with_original_ids<T0>())
    }

    fun init(arg0: FUNDLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FundLock{
            id              : 0x2::object::new(arg1),
            client_vaults   : 0x2::table::new<address, 0x2::bag::Bag>(arg1),
            release_lock_ms : 86400000,
            trade_lock_ms   : 3600000,
        };
        0x2::transfer::share_object<FundLock>(v0);
    }

    public fun release<T0>(arg0: &mut FundLock, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(&arg0.client_vaults, v0), 402);
        let v1 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.client_vaults, v0);
        assert!(has_vault<T0>(v1), 402);
        let v2 = get_vault_mut<T0>(v1);
        assert!(arg1 < 0x1::vector::length<Withdrawal<T0>>(&v2.withdrawals), 405);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x1::vector::borrow<Withdrawal<T0>>(&v2.withdrawals, arg1).timestamp_ms + arg0.release_lock_ms, 403);
        let Withdrawal {
            locked_balance : v3,
            timestamp_ms   : v4,
        } = 0x1::vector::remove<Withdrawal<T0>>(&mut v2.withdrawals, arg1);
        let v5 = v3;
        let v6 = FundsReleased{
            client                  : v0,
            coin_type               : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            amount                  : 0x2::balance::value<T0>(&v5),
            index                   : arg1,
            withdrawal_timestamp_ms : v4,
        };
        0x2::event::emit<FundsReleased>(v6);
        0x2::coin::from_balance<T0>(v5, arg3)
    }

    public fun release_lock_ms(arg0: &FundLock) : u64 {
        arg0.release_lock_ms
    }

    public fun set_release_lock(arg0: &0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::AdminCap, arg1: &0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::CapabilityRegistry, arg2: &mut FundLock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::assert_admin_active(arg0, arg1);
        arg2.release_lock_ms = arg3;
    }

    public fun set_trade_lock(arg0: &0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::AdminCap, arg1: &0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::CapabilityRegistry, arg2: &mut FundLock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::assert_admin_active(arg0, arg1);
        arg2.trade_lock_ms = arg3;
    }

    public fun trade_lock_ms(arg0: &FundLock) : u64 {
        arg0.trade_lock_ms
    }

    public(friend) fun update_balance_deposit<T0>(arg0: &0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::UtilityAccountCap, arg1: &0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::CapabilityRegistry, arg2: &mut FundLock, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::assert_utility_account_active(arg0, arg1);
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg2.client_vaults, arg3)) {
            0x2::table::add<address, 0x2::bag::Bag>(&mut arg2.client_vaults, arg3, 0x2::bag::new(arg6));
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg2.client_vaults, arg3);
        if (has_vault<T0>(v0)) {
            let v1 = get_vault_mut<T0>(v0);
            0x2::balance::join<T0>(&mut v1.balance, 0x2::coin::into_balance<T0>(arg4));
        } else {
            create_vault<T0>(v0, 0x2::coin::into_balance<T0>(arg4), arg6);
        };
        let v2 = BalanceUpdated{
            client     : arg3,
            coin_type  : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            amount     : 0x2::coin::value<T0>(&arg4),
            is_deposit : true,
            backend_id : arg5,
            balance    : 0x2::balance::value<T0>(&get_vault<T0>(v0).balance),
        };
        0x2::event::emit<BalanceUpdated>(v2);
    }

    public(friend) fun update_balance_withdraw<T0>(arg0: &0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::UtilityAccountCap, arg1: &0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::CapabilityRegistry, arg2: &mut FundLock, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::access_control::assert_utility_account_active(arg0, arg1);
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(&arg2.client_vaults, arg3), 401);
        let v0 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg2.client_vaults, arg3);
        assert!(has_vault<T0>(v0), 401);
        let v1 = get_vault_mut<T0>(v0);
        let v2 = 0x2::balance::value<T0>(&v1.balance);
        let v3 = 0x2::balance::zero<T0>();
        if (v2 > 0) {
            let v4 = if (v2 >= arg4) {
                arg4
            } else {
                v2
            };
            0x2::balance::join<T0>(&mut v3, 0x2::balance::split<T0>(&mut v1.balance, v4));
        };
        let v5 = 0x2::balance::value<T0>(&v3);
        if (v5 < arg4) {
            let v6 = arg4 - v5;
            let v7 = fund_from_withdrawal<T0>(v1, arg3, v6, arg2.trade_lock_ms, arg6);
            assert!(0x2::balance::value<T0>(&v7) == v6, 406);
            0x2::balance::join<T0>(&mut v3, v7);
        };
        let v8 = BalanceUpdated{
            client     : arg3,
            coin_type  : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            amount     : arg4,
            is_deposit : false,
            backend_id : arg5,
            balance    : 0x2::balance::value<T0>(&v1.balance),
        };
        0x2::event::emit<BalanceUpdated>(v8);
        0x2::coin::from_balance<T0>(v3, arg7)
    }

    public fun withdraw<T0>(arg0: &mut FundLock, arg1: &0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::token_validator::TokenRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 400);
        0xfa69ccfb553e1e3b504c71ac69c6a3c230803175693c30ada92fa890f585b19a::token_validator::assert_whitelisted<T0>(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(&arg0.client_vaults, v0), 401);
        let v1 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.client_vaults, v0);
        assert!(has_vault<T0>(v1), 401);
        let v2 = get_vault_mut<T0>(v1);
        assert!(0x2::balance::value<T0>(&v2.balance) >= arg2, 401);
        assert!(0x1::vector::length<Withdrawal<T0>>(&v2.withdrawals) < 5, 404);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = Withdrawal<T0>{
            locked_balance : 0x2::balance::split<T0>(&mut v2.balance, arg2),
            timestamp_ms   : v3,
        };
        0x1::vector::push_back<Withdrawal<T0>>(&mut v2.withdrawals, v4);
        let v5 = WithdrawalRequested{
            client       : v0,
            coin_type    : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            amount       : arg2,
            index        : 0x1::vector::length<Withdrawal<T0>>(&v2.withdrawals) - 1,
            timestamp_ms : v3,
            balance      : 0x2::balance::value<T0>(&v2.balance),
        };
        0x2::event::emit<WithdrawalRequested>(v5);
    }

    public fun withdrawal_count<T0>(arg0: &FundLock, arg1: address) : u64 {
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.client_vaults, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.client_vaults, arg1);
        if (!has_vault<T0>(v0)) {
            return 0
        };
        0x1::vector::length<Withdrawal<T0>>(&get_vault<T0>(v0).withdrawals)
    }

    public fun withdrawal_info_amount(arg0: &WithdrawalInfo) : u64 {
        arg0.amount
    }

    public fun withdrawal_info_timestamp_ms(arg0: &WithdrawalInfo) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v6
}

