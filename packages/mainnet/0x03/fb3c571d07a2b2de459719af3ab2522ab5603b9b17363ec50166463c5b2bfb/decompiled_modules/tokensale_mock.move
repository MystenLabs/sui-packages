module 0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tokensale_mock {
    struct Admin has key {
        id: 0x2::object::UID,
    }

    struct Contribution has store {
        amount: u64,
        tokens: u64,
        released_tokens: u64,
        refundable: bool,
    }

    struct IDO<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        token: 0x2::balance::Balance<T0>,
        stable_coin: 0x2::balance::Balance<T1>,
        round: u64,
        round_start_time: u64,
        round_end_time: u64,
        vesting_start: u64,
        contributors: 0x2::table::Table<address, Contribution>,
        max_cap_in_stable: u64,
        min_cap_in_stable: u64,
        tokens_for_sale: u64,
        total_tokens_sold: u64,
        total_stable_received: u64,
        tge_release_percent: u64,
        vesting_time: u64,
        vesting_duration_seconds: u64,
        vesting_withdraw_interval: u64,
        time_lock_seconds: u64,
        refundable_time: u64,
        refundable_bool: bool,
        withdraw_address: address,
        address_check_signature: address,
        black_list: vector<address>,
        is_paused: bool,
    }

    struct ContributionData has copy, drop {
        amount: u64,
        tokens: u64,
        released_tokens: u64,
        address_contribution: address,
    }

    struct AddedLiquidityEvent has copy, drop {
        amount: u64,
        total_balance: u64,
    }

    struct Participate has copy, drop {
        user: address,
        amount: u64,
    }

    struct Released has copy, drop {
        user: address,
        tokens: u64,
    }

    struct StartVesting has copy, drop {
        timestamp: u64,
    }

    struct Withdraw has copy, drop {
        user: address,
        amount: u64,
    }

    struct EmergencyWithdrawTokens has copy, drop {
        user: address,
        amount: u64,
    }

    public fun get_allocation<T0, T1>(arg0: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tier_system_manual_mock::TierSystem, arg1: &IDO<T0, T1>, arg2: address) : u64 {
        0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tier_system_manual_mock::get_allocation(arg0, 0x2::object::uid_to_address(&arg1.id), arg2)
    }

    public fun add_data_to_participation<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: vector<ContributionData>, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<ContributionData>(&arg2)) {
            let v0 = 0x1::vector::pop_back<ContributionData>(&mut arg2);
            if (!0x2::table::contains<address, Contribution>(&arg1.contributors, v0.address_contribution)) {
                let v1 = Contribution{
                    amount          : v0.amount,
                    tokens          : v0.tokens,
                    released_tokens : v0.released_tokens,
                    refundable      : false,
                };
                0x2::table::add<address, Contribution>(&mut arg1.contributors, v0.address_contribution, v1);
                continue
            };
            let v2 = 0x2::table::borrow_mut<address, Contribution>(&mut arg1.contributors, v0.address_contribution);
            v2.amount = v0.amount;
            v2.tokens = v0.tokens;
            v2.released_tokens = v0.released_tokens;
        };
        0x1::vector::destroy_empty<ContributionData>(arg2);
    }

    public entry fun add_token_liquidity<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = AddedLiquidityEvent{
            amount        : 0x2::coin::value<T0>(&arg1),
            total_balance : 0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(arg1)),
        };
        0x2::event::emit<AddedLiquidityEvent>(v0);
    }

    public entry fun add_token_liquidity_with_amount<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(arg2 > 0, 8);
        assert!(v0 >= arg2, 25);
        let v1 = AddedLiquidityEvent{
            amount        : v0,
            total_balance : 0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3))),
        };
        0x2::event::emit<AddedLiquidityEvent>(v1);
        handle_remaining_coin<T0>(arg1, 0x2::tx_context::sender(arg3));
    }

    public fun allowed(arg0: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::kyc_registry_mock::KYCRegistry, arg1: address) : bool {
        0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::kyc_registry_mock::get_status(arg0, arg1)
    }

    public fun black_list_addresses_at<T0, T1>(arg0: &IDO<T0, T1>, arg1: u64) : address {
        *0x1::vector::borrow<address>(&arg0.black_list, arg1)
    }

    public fun change_admin(arg0: Admin, arg1: address) {
        0x2::transfer::transfer<Admin>(arg0, arg1);
    }

    public fun count_of_black_list_addresses<T0, T1>(arg0: &IDO<T0, T1>) : u64 {
        0x1::vector::length<address>(&arg0.black_list)
    }

    public entry fun create_ido<T0, T1>(arg0: &Admin, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: address, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= arg1, 1);
        assert!(arg5 >= arg6, 30);
        assert!(arg3 <= 1000, 27);
        let v0 = IDO<T0, T1>{
            id                        : 0x2::object::new(arg11),
            version                   : 0,
            token                     : 0x2::balance::zero<T0>(),
            stable_coin               : 0x2::balance::zero<T1>(),
            round                     : 0,
            round_start_time          : 0,
            round_end_time            : 0,
            vesting_start             : 0,
            contributors              : 0x2::table::new<address, Contribution>(arg11),
            max_cap_in_stable         : arg2,
            min_cap_in_stable         : arg1,
            tokens_for_sale           : arg4,
            total_tokens_sold         : 0,
            total_stable_received     : 0,
            tge_release_percent       : arg3,
            vesting_time              : 0,
            vesting_duration_seconds  : arg5,
            vesting_withdraw_interval : arg6,
            time_lock_seconds         : arg7,
            refundable_time           : 0,
            refundable_bool           : false,
            withdraw_address          : arg8,
            address_check_signature   : arg9,
            black_list                : 0x1::vector::empty<address>(),
            is_paused                 : arg10,
        };
        0x2::transfer::share_object<IDO<T0, T1>>(v0);
    }

    public fun current_vested_amount<T0, T1>(arg0: &IDO<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::table::borrow<address, Contribution>(&arg0.contributors, arg1);
        let v1 = vesting_schedule<T0, T1>(arg0, v0.tokens, 0x2::clock::timestamp_ms(arg2));
        if (v0.released_tokens >= v1) {
            return v0.released_tokens
        };
        v1
    }

    public fun emergency_withdraw_tokens<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token, arg2), arg4), arg3);
        let v0 = EmergencyWithdrawTokens{
            user   : arg3,
            amount : arg2,
        };
        0x2::event::emit<EmergencyWithdrawTokens>(v0);
    }

    public entry fun finish_ido<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.total_stable_received >= arg1.min_cap_in_stable, 14);
        assert!(is_ido_finished<T0, T1>(arg1, arg3), 7);
        start_vesting<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun finish_ido_max_cap<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tier_system_manual_mock::TierSystem, arg3: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::kyc_registry_mock::KYCRegistry, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.max_cap_in_stable - arg1.total_stable_received;
        participate_ido<T0, T1>(arg1, arg2, arg3, v0, arg4, arg6, arg7);
        start_vesting<T0, T1>(arg0, arg1, arg5, arg6);
    }

    public entry fun finish_ido_min_cap<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tier_system_manual_mock::TierSystem, arg3: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::kyc_registry_mock::KYCRegistry, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.min_cap_in_stable > arg1.total_stable_received, 6);
        let v0 = arg1.min_cap_in_stable - arg1.total_stable_received;
        participate_ido<T0, T1>(arg1, arg2, arg3, v0, arg4, arg6, arg7);
        start_vesting<T0, T1>(arg0, arg1, arg5, arg6);
    }

    public entry fun first_round_participate<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tier_system_manual_mock::TierSystem, arg2: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::kyc_registry_mock::KYCRegistry, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round == 1, 4);
        participate_ido<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun get_actual_amount_stables<T0, T1>(arg0: &IDO<T0, T1>, arg1: u64) : u64 {
        let v0 = if (arg1 + arg0.total_stable_received <= arg0.max_cap_in_stable) {
            arg1
        } else {
            arg0.max_cap_in_stable - arg0.total_stable_received
        };
        assert!(v0 != 0, 6);
        v0
    }

    public fun get_available_participate_amount<T0, T1>(arg0: &IDO<T0, T1>, arg1: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tier_system_manual_mock::TierSystem, arg2: address) : u64 {
        let v0 = 0x2::table::borrow<address, Contribution>(&arg0.contributors, arg2);
        let v1 = get_allocation<T0, T1>(arg1, arg0, arg2);
        if (v1 == 0) {
            return 0
        };
        v1 - v0.amount
    }

    public fun get_refund_bool<T0, T1>(arg0: &IDO<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!arg0.refundable_bool) {
            return false
        };
        let v0 = 0x2::table::borrow<address, Contribution>(&arg0.contributors, arg1);
        if (v0.amount == 0) {
            return false
        };
        if (v0.released_tokens > 0) {
            return false
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 < arg0.vesting_time) {
            return false
        };
        if (v1 > arg0.vesting_time + arg0.refundable_time) {
            return false
        };
        true
    }

    public fun get_refundable_time<T0, T1>(arg0: &IDO<T0, T1>) : u64 {
        arg0.vesting_time + arg0.refundable_time
    }

    public fun get_token_for_stables<T0, T1>(arg0: &IDO<T0, T1>, arg1: u64) : u64 {
        arg1 * arg0.tokens_for_sale / arg0.max_cap_in_stable
    }

    fun handle_coin<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.stable_coin, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, arg3, arg4)));
        handle_remaining_coin<T1>(arg1, arg2);
    }

    fun handle_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_ido_finished<T0, T1>(arg0: &IDO<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.round_end_time
    }

    public fun is_ido_paused<T0, T1>(arg0: &IDO<T0, T1>) : bool {
        arg0.is_paused
    }

    public fun is_ido_started<T0, T1>(arg0: &IDO<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.round_start_time
    }

    fun participate_checks<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tier_system_manual_mock::TierSystem, arg2: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::kyc_registry_mock::KYCRegistry, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(is_ido_started<T0, T1>(arg0, arg5), 5);
        assert!(!is_ido_finished<T0, T1>(arg0, arg5), 6);
        assert!(arg0.vesting_start == 0, 6);
        assert!(arg4 != 0, 8);
        assert!(allowed(arg2, arg3), 10);
        if (!0x2::table::contains<address, Contribution>(&arg0.contributors, arg3)) {
            let v0 = Contribution{
                amount          : 0,
                tokens          : 0,
                released_tokens : 0,
                refundable      : false,
            };
            0x2::table::add<address, Contribution>(&mut arg0.contributors, arg3, v0);
        };
        let v1 = get_available_participate_amount<T0, T1>(arg0, arg1, arg3);
        assert!(v1 != 0, 11);
        assert!(v1 >= arg4, 12);
    }

    fun participate_ido<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tier_system_manual_mock::TierSystem, arg2: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::kyc_registry_mock::KYCRegistry, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!is_ido_paused<T0, T1>(arg0), 3);
        assert!(0x2::coin::value<T1>(&arg4) >= arg3, 9);
        let v0 = 0x2::tx_context::sender(arg6);
        participate_checks<T0, T1>(arg0, arg1, arg2, v0, arg3, arg5);
        let v1 = get_actual_amount_stables<T0, T1>(arg0, arg3);
        process_contribution<T0, T1>(arg0, v0, v1);
        let v2 = Participate{
            user   : v0,
            amount : v1,
        };
        0x2::event::emit<Participate>(v2);
        handle_coin<T0, T1>(arg0, arg4, v0, v1, arg6);
    }

    fun process_contribution<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: address, arg2: u64) {
        let v0 = get_token_for_stables<T0, T1>(arg0, arg2);
        let v1 = 0x2::table::borrow_mut<address, Contribution>(&mut arg0.contributors, arg1);
        v1.amount = v1.amount + arg2;
        v1.tokens = v1.tokens + v0;
        arg0.total_stable_received = arg0.total_stable_received + arg2;
        arg0.total_tokens_sold = arg0.total_tokens_sold + v0;
    }

    public entry fun refund<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.refundable_bool, 15);
        assert!(arg0.vesting_time != 0, 16);
        assert!(v0 >= arg0.vesting_time, 17);
        assert!(v0 <= arg0.vesting_time + arg0.refundable_time, 18);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::table::borrow_mut<address, Contribution>(&mut arg0.contributors, v1);
        assert!(v2.released_tokens == 0, 19);
        assert!(v2.amount != 0, 20);
        arg0.total_stable_received = arg0.total_stable_received - v2.amount;
        arg0.total_tokens_sold = arg0.total_tokens_sold - v2.tokens;
        v2.amount = 0;
        v2.released_tokens = 0;
        v2.tokens = 0;
        v2.refundable = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.stable_coin, v2.amount), arg2), v1);
    }

    public entry fun release<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!is_ido_paused<T0, T1>(arg0), 3);
        assert!(arg0.vesting_time != 0, 16);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.vesting_start, 17);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Contribution>(&arg0.contributors, v0), 29);
        let v1 = 0x2::table::borrow_mut<address, Contribution>(&mut arg0.contributors, v0);
        let v2 = current_vested_amount<T0, T1>(arg0, v0, arg1) - v1.released_tokens;
        assert!(v2 != 0, 26);
        v1.released_tokens = v1.released_tokens + v2;
        let v3 = Released{
            user   : v0,
            tokens : v2,
        };
        0x2::event::emit<Released>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token, v2), arg2), v0);
    }

    public entry fun second_round_participate<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tier_system_manual_mock::TierSystem, arg2: &0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::kyc_registry_mock::KYCRegistry, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round == 2, 4);
        let v0 = 0x2::tx_context::sender(arg9);
        if (0x2::clock::timestamp_ms(arg7) >= arg3) {
            0x1::vector::push_back<address>(&mut arg0.black_list, v0);
            handle_remaining_coin<T1>(arg6, v0);
            return
        };
        participate_ido<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg9);
    }

    public fun set_pause<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_paused = arg2;
    }

    public fun set_refundable_bool<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.refundable_bool = arg2;
    }

    public fun set_refundable_time<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.refundable_time = arg2;
    }

    public entry fun set_round<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg5), 28);
        assert!(arg3 >= arg2, 0);
        assert!(arg4 == 1 || arg4 == 2, 13);
        arg1.round_start_time = arg2;
        arg1.round_end_time = arg3;
        arg1.round = arg4;
    }

    public entry fun start_vesting<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.round_end_time != 0, 5);
        assert!(arg2 >= v0, 23);
        assert!(arg1.vesting_time > v0 || arg1.vesting_time == 0, 24);
        arg1.vesting_time = arg2;
        arg1.vesting_start = arg1.vesting_time + arg1.time_lock_seconds;
        let v1 = StartVesting{timestamp: arg1.vesting_time};
        0x2::event::emit<StartVesting>(v1);
    }

    public fun team_withdraw<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.withdraw_address, 21);
        assert!(arg0.vesting_start != 0, 7);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.vesting_time + arg0.refundable_time, 22);
        assert!(arg0.total_stable_received != 0, 2);
        let v1 = arg0.total_stable_received;
        arg0.total_stable_received = 0;
        let v2 = Withdraw{
            user   : v0,
            amount : v1,
        };
        0x2::event::emit<Withdraw>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.stable_coin, v1), arg2), v0);
    }

    public fun vested_amount<T0, T1>(arg0: &IDO<T0, T1>, arg1: address, arg2: u64) : u64 {
        let v0 = 0x2::table::borrow<address, Contribution>(&arg0.contributors, arg1);
        let v1 = vesting_schedule<T0, T1>(arg0, v0.tokens, arg2);
        if (v0.released_tokens >= v1) {
            return v0.released_tokens
        };
        v1
    }

    fun vesting_schedule<T0, T1>(arg0: &IDO<T0, T1>, arg1: u64, arg2: u64) : u64 {
        if (arg0.vesting_time == 0) {
            return 0
        };
        if (arg0.vesting_time > arg2) {
            return 0
        };
        let v0 = arg1 * arg0.tge_release_percent / 1000;
        if (arg2 < arg0.vesting_start) {
            if (arg2 + arg0.time_lock_seconds < arg0.vesting_start) {
                return 0
            };
            return v0
        };
        if (arg2 > arg0.vesting_start + arg0.vesting_duration_seconds) {
            return arg1
        };
        let v1 = arg1 - v0;
        if (v1 == 0) {
            return v0
        };
        let v2 = v1 * (arg2 - arg0.vesting_start) / arg0.vesting_duration_seconds;
        v0 + v2 - v2 % v1 / arg0.vesting_duration_seconds / arg0.vesting_withdraw_interval
    }

    // decompiled from Move bytecode v6
}

