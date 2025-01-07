module 0x339046c59c4ded9f31ed7da0c8adb64bea723a1836c6e0dca090aa17fce8a8a5::staking_mock {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        token: 0x2::balance::Balance<T0>,
        bonus_amounts: u64,
        lock_period: u64,
        withdrawal_penalty: u64,
        addressFee: address,
        pause: bool,
        stop_deposit: bool,
        deposited_amounts: 0x2::table::Table<address, u64>,
        current_dates: 0x2::table::Table<address, u64>,
        all_users_addresses: 0x2::vec_set::VecSet<address>,
        another_staking_without_fee: vector<0x2::object::ID>,
        total_deposit: u64,
    }

    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        dummy_field: bool,
    }

    struct RemoveAllTokensFromContract has copy, drop {
        amount: u64,
    }

    struct AddedLiquidityEvent has copy, drop {
        amount: u64,
        pool_balance: u64,
    }

    struct AllInfoUser has drop {
        time_withdraw: u64,
        reward_user: u64,
        time_with_lock_period: u64,
        time_without_lock_period: u64,
        total_deposit: u64,
        count_participants: u64,
        amount_user: u64,
        status_user: 0x1::string::String,
        another_staking_without_fee: vector<0x2::object::ID>,
    }

    fun add_amount_to_user<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.deposited_amounts, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposited_amounts, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.deposited_amounts, arg1, arg2);
        };
    }

    public entry fun add_pool_liquidity<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AddedLiquidityEvent{
            amount       : 0x2::coin::value<T0>(&arg1),
            pool_balance : 0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(arg1)),
        };
        0x2::event::emit<AddedLiquidityEvent>(v0);
    }

    public entry fun add_pool_liquidity_with_amount<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 3);
        handle_remaining_coin<T0>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = AddedLiquidityEvent{
            amount       : arg2,
            pool_balance : 0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3))),
        };
        0x2::event::emit<AddedLiquidityEvent>(v0);
    }

    fun add_ts_to_user<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &0x2::clock::Clock) {
        if (0x2::table::contains<address, u64>(&arg0.current_dates, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.current_dates, arg1) = 0x2::clock::timestamp_ms(arg2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.current_dates, arg1, 0x2::clock::timestamp_ms(arg2));
        };
    }

    public fun all_users_addresses_at<T0>(arg0: &Pool<T0>, arg1: u64) : address {
        *0x1::vector::borrow<address>(0x2::vec_set::keys<address>(&arg0.all_users_addresses), arg1)
    }

    public fun balance_of<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token)
    }

    public fun change_admin(arg0: Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Admin>(arg0, arg1);
    }

    public fun change_bonus_amounts<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.bonus_amounts = arg2;
    }

    public fun change_lock_period<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.lock_period = arg2;
    }

    fun check_balance_and_add_rewards<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.deposited_amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.deposited_amounts, arg1)
        } else {
            0
        };
        if (v0 > 0) {
            arg0.total_deposit = arg0.total_deposit - v0;
            let v1 = 0x2::clock::timestamp_ms(arg2);
            let v2 = *0x2::table::borrow<address, u64>(&arg0.current_dates, arg1);
            assert!(v1 > v2, 7);
            let v3 = if (v1 - v2 > arg0.lock_period) {
                100
            } else {
                (v1 - v2) * 100 / arg0.lock_period
            };
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposited_amounts, arg1);
            *v4 = v0 + v0 * arg0.bonus_amounts * v3 / 100 / 1000;
            arg0.total_deposit = arg0.total_deposit + *v4;
        };
    }

    public fun count_of_all_users_addresses<T0>(arg0: &Pool<T0>) : u64 {
        0x2::vec_set::size<address>(&arg0.all_users_addresses)
    }

    public fun create_pool<T0>(arg0: &Admin, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id                          : 0x2::object::new(arg7),
            version                     : 0,
            token                       : 0x2::balance::zero<T0>(),
            bonus_amounts               : arg2,
            lock_period                 : arg3,
            withdrawal_penalty          : arg4,
            addressFee                  : arg1,
            pause                       : arg5,
            stop_deposit                : arg6,
            deposited_amounts           : 0x2::table::new<address, u64>(arg7),
            current_dates               : 0x2::table::new<address, u64>(arg7),
            all_users_addresses         : 0x2::vec_set::empty<address>(),
            another_staking_without_fee : 0x1::vector::empty<0x2::object::ID>(),
            total_deposit               : 0,
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.stop_deposit, 0);
        assert!(arg2 > 0, 2);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        check_balance_and_add_rewards<T0>(arg0, v0, arg3);
        add_amount_to_user<T0>(arg0, v0, arg2);
        add_ts_to_user<T0>(arg0, v0, arg3);
        0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg4)));
        handle_remaining_coin<T0>(arg1, v0);
        arg0.total_deposit = arg0.total_deposit + arg2;
        if (!0x2::vec_set::contains<address>(&arg0.all_users_addresses, &v0)) {
            0x2::vec_set::insert<address>(&mut arg0.all_users_addresses, v0);
        };
        let v1 = DepositEvent{amount: arg2};
        0x2::event::emit<DepositEvent>(v1);
    }

    public entry fun deposit_all<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.stop_deposit, 0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = 0x2::tx_context::sender(arg3);
        check_balance_and_add_rewards<T0>(arg0, v1, arg2);
        add_amount_to_user<T0>(arg0, v1, v0);
        add_ts_to_user<T0>(arg0, v1, arg2);
        0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposit = arg0.total_deposit + v0;
        if (!0x2::vec_set::contains<address>(&arg0.all_users_addresses, &v1)) {
            0x2::vec_set::insert<address>(&mut arg0.all_users_addresses, v1);
        };
        let v2 = DepositEvent{amount: v0};
        0x2::event::emit<DepositEvent>(v2);
    }

    public entry fun deposit_all_to_user<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.stop_deposit, 0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        check_balance_and_add_rewards<T0>(arg0, arg2, arg3);
        add_amount_to_user<T0>(arg0, arg2, v0);
        add_ts_to_user<T0>(arg0, arg2, arg3);
        0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposit = arg0.total_deposit + v0;
        if (!0x2::vec_set::contains<address>(&arg0.all_users_addresses, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.all_users_addresses, arg2);
        };
        let v1 = DepositEvent{amount: v0};
        0x2::event::emit<DepositEvent>(v1);
    }

    public entry fun deposit_to_user<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.stop_deposit, 0);
        assert!(arg3 > 0, 2);
        assert!(0x2::coin::value<T0>(&arg1) >= arg3, 3);
        check_balance_and_add_rewards<T0>(arg0, arg2, arg4);
        add_amount_to_user<T0>(arg0, arg2, arg3);
        add_ts_to_user<T0>(arg0, arg2, arg4);
        0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg3, arg5)));
        handle_remaining_coin<T0>(arg1, 0x2::tx_context::sender(arg5));
        arg0.total_deposit = arg0.total_deposit + arg3;
        if (!0x2::vec_set::contains<address>(&arg0.all_users_addresses, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.all_users_addresses, arg2);
        };
        let v0 = DepositEvent{amount: arg3};
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun get_all_info_user<T0>(arg0: &Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : AllInfoUser {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = get_time_withdraw<T0>(arg0, arg1, arg2);
        let v2 = get_rewards_user<T0>(arg0, arg2);
        let v3 = get_time_with_lock_period<T0>(arg0, arg1, arg2);
        AllInfoUser{
            time_withdraw               : v1,
            reward_user                 : v2,
            time_with_lock_period       : v3,
            time_without_lock_period    : *0x2::table::borrow<address, u64>(&arg0.current_dates, v0),
            total_deposit               : arg0.total_deposit,
            count_participants          : count_of_all_users_addresses<T0>(arg0),
            amount_user                 : *0x2::table::borrow<address, u64>(&arg0.deposited_amounts, v0),
            status_user                 : get_status_user<T0>(arg0, arg2),
            another_staking_without_fee : arg0.another_staking_without_fee,
        }
    }

    public fun get_another_staking_without_fee<T0>(arg0: &Pool<T0>) : vector<0x2::object::ID> {
        arg0.another_staking_without_fee
    }

    public fun get_pool_ID<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_pool_addressFee<T0>(arg0: &Pool<T0>) : address {
        arg0.addressFee
    }

    public fun get_pool_bonus_amounts<T0>(arg0: &Pool<T0>) : u64 {
        arg0.bonus_amounts
    }

    public fun get_pool_is_pause<T0>(arg0: &Pool<T0>) : bool {
        arg0.pause
    }

    public fun get_pool_is_stop_deposit<T0>(arg0: &Pool<T0>) : bool {
        arg0.stop_deposit
    }

    public fun get_pool_lock_period<T0>(arg0: &Pool<T0>) : u64 {
        arg0.lock_period
    }

    public fun get_pool_total_deposit<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_deposit
    }

    public fun get_pool_user_deposited_amount<T0>(arg0: &Pool<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.deposited_amounts, arg1)
    }

    public fun get_pool_user_ts<T0>(arg0: &Pool<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.current_dates, arg1)
    }

    public fun get_pool_withdrawal_penalty<T0>(arg0: &Pool<T0>) : u64 {
        arg0.withdrawal_penalty
    }

    public fun get_rewards_user<T0>(arg0: &Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.deposited_amounts, 0x2::tx_context::sender(arg1)) * arg0.bonus_amounts / 1000
    }

    public fun get_status_user<T0>(arg0: &Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        if (*0x2::table::borrow<address, u64>(&arg0.deposited_amounts, 0x2::tx_context::sender(arg1)) > 0) {
            return 0x1::string::utf8(b"PARTICIPATE")
        };
        0x1::string::utf8(b"NOT_PARTICIPATE")
    }

    public fun get_time_with_lock_period<T0>(arg0: &Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.current_dates, 0x2::tx_context::sender(arg2)) + 0x2::clock::timestamp_ms(arg1)
    }

    public fun get_time_withdraw<T0>(arg0: &Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = *0x2::table::borrow<address, u64>(&arg0.current_dates, 0x2::tx_context::sender(arg2));
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (v1 < v0 + arg0.lock_period) {
            return v0 + arg0.lock_period - v1
        };
        0
    }

    public fun get_users_current_rewards<T0>(arg0: &Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.current_dates, v0);
        assert!(v1 > v2, 7);
        let v3 = if (v1 - v2 > arg0.lock_period) {
            100
        } else {
            (v1 - v2) * 100 / arg0.lock_period
        };
        *0x2::table::borrow<address, u64>(&arg0.deposited_amounts, v0) * arg0.bonus_amounts * v3 / 100 / 1000
    }

    fun handle_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun how_much_deposit<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg1.total_deposit * arg1.bonus_amounts / 1000;
        if (balance_of<T0>(arg1) > v0 + arg1.total_deposit) {
            return 0
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun manage_state_deposit<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.stop_deposit = arg2;
    }

    public entry fun migrate<T0>(arg0: &mut Pool<T0>, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.another_staking_without_fee, &v0), 8);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = get_pool_user_deposited_amount<T0>(arg0, v1);
        assert!(v2 > 0, 3);
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token, v2), arg3);
        deposit_all<T0>(arg1, v3, arg2, arg3);
        assert!(0x2::balance::value<T0>(&arg0.token) - v2 == 0x2::balance::value<T0>(&arg0.token), 9);
        arg0.total_deposit = arg0.total_deposit - v2;
        *0x2::table::borrow_mut<address, u64>(&mut arg0.deposited_amounts, v1) = 0;
        *0x2::table::borrow_mut<address, u64>(&mut arg0.current_dates, v1) = 0;
    }

    public fun set_address_fee<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.addressFee = arg2;
    }

    public fun set_another_staking_adresses<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.another_staking_without_fee = arg2;
    }

    public fun set_pause<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.pause = arg2;
    }

    public fun set_penalty<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.withdrawal_penalty = arg2;
    }

    public entry fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.pause, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.deposited_amounts, v0), 4);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.deposited_amounts, v0);
        assert!(v1 > 0, 5);
        let v2 = if (0x2::clock::timestamp_ms(arg1) < *0x2::table::borrow<address, u64>(&arg0.current_dates, v0) + arg0.lock_period) {
            let v3 = v1 * (1000 - arg0.withdrawal_penalty) / 1000;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token, v1 - v3), arg2), arg0.addressFee);
            v3
        } else {
            v1 + v1 * arg0.bonus_amounts / 1000
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token, v2), arg2), v0);
        arg0.total_deposit = arg0.total_deposit - v1;
        *0x2::table::borrow_mut<address, u64>(&mut arg0.deposited_amounts, v0) = 0;
        *0x2::table::borrow_mut<address, u64>(&mut arg0.current_dates, v0) = 0;
        let v4 = WithdrawEvent{dummy_field: false};
        0x2::event::emit<WithdrawEvent>(v4);
    }

    public fun withdraw_all_funds<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = RemoveAllTokensFromContract{amount: arg2};
        0x2::event::emit<RemoveAllTokensFromContract>(v0);
    }

    public fun withdraw_all_funds_and_bonus_for_users<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = *0x2::table::borrow<address, u64>(&arg1.deposited_amounts, v1);
            assert!(v2 > 0, 6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token, v2 + v2 * arg1.bonus_amounts / 1000), arg3), v1);
            arg1.total_deposit = arg1.total_deposit - v2;
            *0x2::table::borrow_mut<address, u64>(&mut arg1.deposited_amounts, v1) = 0;
            *0x2::table::borrow_mut<address, u64>(&mut arg1.current_dates, v1) = 0;
            v0 = v0 + 1;
        };
    }

    public fun withdraw_all_funds_for_users<T0>(arg0: &Admin, arg1: &mut Pool<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = *0x2::table::borrow<address, u64>(&arg1.deposited_amounts, v1);
            assert!(v2 > 0, 6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token, v2), arg3), v1);
            arg1.total_deposit = arg1.total_deposit - v2;
            *0x2::table::borrow_mut<address, u64>(&mut arg1.deposited_amounts, v1) = 0;
            *0x2::table::borrow_mut<address, u64>(&mut arg1.current_dates, v1) = 0;
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

