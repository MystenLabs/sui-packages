module 0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tokensale {
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
        pub_key_check_signature: vector<u8>,
        kyc_registry_id: 0x2::object::ID,
        tier_system_id: 0x2::object::ID,
        blacklist: vector<address>,
        is_paused: bool,
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

    struct EmergencyWithdrawStables has copy, drop {
        user: address,
        amount: u64,
    }

    public fun get_allocation<T0, T1>(arg0: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem, arg1: &IDO<T0, T1>, arg2: address) : u64 {
        assert!(arg1.tier_system_id == 0x2::object::id<0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem>(arg0), 33);
        0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::get_allocation(arg0, 0x2::object::uid_to_address(&arg1.id), arg2)
    }

    public fun add_data_to_participation<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<address>) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        let v1 = 0x1::vector::length<u64>(&arg4);
        assert!(0x1::vector::length<u64>(&arg2) == v0 && v0 == v1 && v1 == 0x1::vector::length<address>(&arg5), 37);
        while (!0x1::vector::is_empty<address>(&arg5)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg2);
            let v3 = 0x1::vector::pop_back<u64>(&mut arg3);
            let v4 = 0x1::vector::pop_back<u64>(&mut arg4);
            let v5 = 0x1::vector::pop_back<address>(&mut arg5);
            if (!0x2::table::contains<address, Contribution>(&arg1.contributors, v5)) {
                let v6 = Contribution{
                    amount          : v2,
                    tokens          : v3,
                    released_tokens : v4,
                    refundable      : false,
                };
                0x2::table::add<address, Contribution>(&mut arg1.contributors, v5, v6);
                continue
            };
            let v7 = 0x2::table::borrow_mut<address, Contribution>(&mut arg1.contributors, v5);
            v7.amount = v2;
            v7.tokens = v3;
            v7.released_tokens = v4;
        };
        0x1::vector::destroy_empty<u64>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
        0x1::vector::destroy_empty<u64>(arg4);
        0x1::vector::destroy_empty<address>(arg5);
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

    public fun allowed(arg0: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistry, arg1: address) : bool {
        0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::get_status(arg0, arg1)
    }

    public fun blacklist_addresses_at<T0, T1>(arg0: &IDO<T0, T1>, arg1: u64) : address {
        *0x1::vector::borrow<address>(&arg0.blacklist, arg1)
    }

    public fun change_admin(arg0: Admin, arg1: address) {
        0x2::transfer::transfer<Admin>(arg0, arg1);
    }

    public fun count_of_blacklist_addresses<T0, T1>(arg0: &IDO<T0, T1>) : u64 {
        0x1::vector::length<address>(&arg0.blacklist)
    }

    public entry fun create_ido<T0, T1>(arg0: &Admin, arg1: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystemOwner, arg2: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistryOwner, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: vector<u8>, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 34);
        assert!(arg4 >= arg3, 1);
        assert!(arg8 > 0, 30);
        assert!(arg7 >= arg8, 0);
        assert!(arg7 % arg8 == 0, 36);
        assert!(arg5 <= 1000, 27);
        assert!(0x1::vector::length<u8>(&arg11) == 32 || 0x1::vector::is_empty<u8>(&arg11), 31);
        let v0 = IDO<T0, T1>{
            id                        : 0x2::object::new(arg13),
            version                   : 0,
            token                     : 0x2::balance::zero<T0>(),
            stable_coin               : 0x2::balance::zero<T1>(),
            round                     : 0,
            round_start_time          : 0,
            round_end_time            : 0,
            vesting_start             : 0,
            contributors              : 0x2::table::new<address, Contribution>(arg13),
            max_cap_in_stable         : arg4,
            min_cap_in_stable         : arg3,
            tokens_for_sale           : arg6,
            total_tokens_sold         : 0,
            total_stable_received     : 0,
            tge_release_percent       : arg5,
            vesting_time              : 0,
            vesting_duration_seconds  : arg7,
            vesting_withdraw_interval : arg8,
            time_lock_seconds         : arg9,
            refundable_time           : 0,
            refundable_bool           : false,
            withdraw_address          : arg10,
            pub_key_check_signature   : arg11,
            kyc_registry_id           : 0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::create_kyc(arg2, arg13),
            tier_system_id            : 0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::create_tier_system(arg1, arg13),
            blacklist                 : 0x1::vector::empty<address>(),
            is_paused                 : arg12,
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

    public fun emergency_withdraw_stables<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.stable_coin, arg2), arg4), arg3);
        let v0 = EmergencyWithdrawStables{
            user   : arg3,
            amount : arg2,
        };
        0x2::event::emit<EmergencyWithdrawStables>(v0);
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

    public entry fun finish_ido_max_cap<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem, arg3: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistry, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.max_cap_in_stable - arg1.total_stable_received;
        participate_ido<T0, T1>(arg1, arg2, arg3, v0, arg4, arg6, arg7);
        start_vesting<T0, T1>(arg0, arg1, arg5, arg6);
    }

    public entry fun finish_ido_min_cap<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem, arg3: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistry, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.min_cap_in_stable > arg1.total_stable_received, 6);
        let v0 = arg1.min_cap_in_stable - arg1.total_stable_received;
        participate_ido<T0, T1>(arg1, arg2, arg3, v0, arg4, arg6, arg7);
        start_vesting<T0, T1>(arg0, arg1, arg5, arg6);
    }

    public entry fun first_round_participate<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem, arg2: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistry, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
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

    public fun get_available_participate_amount<T0, T1>(arg0: &IDO<T0, T1>, arg1: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem, arg2: address) : u64 {
        assert!(arg0.tier_system_id == 0x2::object::id<0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem>(arg1), 33);
        let v0 = 0x2::table::borrow<address, Contribution>(&arg0.contributors, arg2);
        let v1 = get_allocation<T0, T1>(arg1, arg0, arg2);
        if (v1 == 0) {
            return 0
        };
        v1 - v0.amount
    }

    public fun get_kyc_registry_id<T0, T1>(arg0: &IDO<T0, T1>) : 0x2::object::ID {
        arg0.kyc_registry_id
    }

    public fun get_participant_data<T0, T1>(arg0: &IDO<T0, T1>, arg1: address) : (u64, u64, u64, bool) {
        let v0 = 0x2::table::borrow<address, Contribution>(&arg0.contributors, arg1);
        (v0.amount, v0.tokens, v0.released_tokens, v0.refundable)
    }

    public fun get_pause<T0, T1>(arg0: &IDO<T0, T1>) : bool {
        arg0.is_paused
    }

    public fun get_pk_check_signature<T0, T1>(arg0: &IDO<T0, T1>) : vector<u8> {
        arg0.pub_key_check_signature
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

    public fun get_refundable_bool<T0, T1>(arg0: &IDO<T0, T1>) : bool {
        arg0.refundable_bool
    }

    public fun get_refundable_time<T0, T1>(arg0: &IDO<T0, T1>) : u64 {
        if (!arg0.refundable_bool) {
            return 0
        };
        if (arg0.refundable_time == 0) {
            return 0
        };
        if (arg0.vesting_time == 0) {
            return 0
        };
        arg0.vesting_time + arg0.refundable_time
    }

    public fun get_refundable_time_value<T0, T1>(arg0: &IDO<T0, T1>) : u64 {
        arg0.refundable_time
    }

    public fun get_round_ido<T0, T1>(arg0: &IDO<T0, T1>) : u64 {
        arg0.round
    }

    public fun get_tier_system_id<T0, T1>(arg0: &IDO<T0, T1>) : 0x2::object::ID {
        arg0.tier_system_id
    }

    public fun get_token_for_stables<T0, T1>(arg0: &IDO<T0, T1>, arg1: u64) : u64 {
        arg1 * arg0.tokens_for_sale / arg0.max_cap_in_stable
    }

    fun handle_coin<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.stable_coin, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, arg3, arg4)));
        handle_remaining_coin<T1>(arg1, arg2);
    }

    fun handle_participation_failure<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: address) {
        if (!0x1::vector::contains<address>(&arg0.blacklist, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.blacklist, arg2);
        };
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

    fun participate_checks<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem, arg2: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistry, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(is_ido_started<T0, T1>(arg0, arg5), 5);
        assert!(!is_ido_finished<T0, T1>(arg0, arg5), 6);
        assert!(arg0.vesting_start == 0, 24);
        assert!(arg4 != 0, 8);
        assert!(arg0.tier_system_id == 0x2::object::id<0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem>(arg1), 33);
        assert!(arg0.kyc_registry_id == 0x2::object::id<0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistry>(arg2), 32);
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

    fun participate_ido<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem, arg2: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistry, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
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

    public entry fun second_round_participate<T0, T1>(arg0: &mut IDO<T0, T1>, arg1: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem, arg2: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistry, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round == 2, 4);
        let v0 = 0x2::tx_context::sender(arg8);
        if (0x2::clock::timestamp_ms(arg7) >= arg3) {
            handle_participation_failure<T0, T1>(arg0, arg6, v0);
            return
        };
        if (!0x1::vector::is_empty<u8>(&arg0.pub_key_check_signature)) {
            let v1 = 0x2::bcs::to_bytes<address>(&v0);
            0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
            let v2 = 0x2::hash::blake2b256(&v1);
            if (!0x2::ed25519::ed25519_verify(&arg4, &arg0.pub_key_check_signature, &v2)) {
                handle_participation_failure<T0, T1>(arg0, arg6, v0);
                return
            };
        };
        participate_ido<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg8);
    }

    public fun set_kyc_registry_id<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistry) {
        arg1.kyc_registry_id = 0x2::object::id<0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::kyc_registry::KYCRegistry>(arg2);
    }

    public fun set_pause<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: bool) {
        arg1.is_paused = arg2;
    }

    public fun set_pk_check_signature<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32 || 0x1::vector::is_empty<u8>(&arg2), 31);
        arg1.pub_key_check_signature = arg2;
    }

    public fun set_refundable_bool<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: bool) {
        arg1.refundable_bool = arg2;
    }

    public fun set_refundable_time<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: u64) {
        arg1.refundable_time = arg2;
    }

    public entry fun set_round<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg5), 28);
        assert!(arg3 >= arg2, 0);
        assert!(arg4 == 1 || arg4 == 2, 13);
        arg1.round_start_time = arg2;
        arg1.round_end_time = arg3;
        arg1.round = arg4;
    }

    public fun set_tier_system_id<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: &0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem) {
        arg1.tier_system_id = 0x2::object::id<0xe9b4ac6b44dffa8017b4e2cc9e7662b89566d8e57884611c0f544b7c2a1d26a2::tier_system_manual::TierSystem>(arg2);
    }

    public entry fun start_vesting<T0, T1>(arg0: &Admin, arg1: &mut IDO<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.round_end_time != 0, 5);
        assert!(arg2 >= v0, 23);
        assert!(arg1.vesting_time > v0 || arg1.vesting_time == 0, 24);
        assert!(0x2::balance::value<T1>(&arg1.stable_coin) != 0, 35);
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

