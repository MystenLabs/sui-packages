module 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>,
        withdrawals_renounced: bool,
        initial_supply_deposited: bool,
    }

    struct TreasuryWithdrawn has copy, drop {
        treasury_object_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        treasury_balance_after: u64,
    }

    struct TreasuryWithdrawalsRenounced has copy, drop {
        treasury_id: 0x2::object::ID,
        admin: address,
    }

    struct PrizeReserve has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>,
        reserve_contribution_window_started_ms: u64,
        reserve_contributed_this_window: u64,
        reserve_contribution_cap_permanently_disabled: bool,
    }

    struct GameReserveContributionRouted has copy, drop {
        window_started_ms: u64,
        current_supply: u64,
        dynamic_cap: u64,
        contributed_before: u64,
        requested_reserve_amount: u64,
        sent_to_reserve: u64,
        burned_excess: u64,
        contributed_after: u64,
        cap_disabled: bool,
    }

    public fun balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg0.balance)
    }

    public fun id(arg0: &Treasury) : 0x2::object::ID {
        0x2::object::id<Treasury>(arg0)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Treasury, PrizeReserve) {
        let v0 = Treasury{
            id                       : 0x2::object::new(arg0),
            balance                  : 0x2::balance::zero<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(),
            withdrawals_renounced    : false,
            initial_supply_deposited : false,
        };
        let v1 = PrizeReserve{
            id                                            : 0x2::object::new(arg0),
            balance                                       : 0x2::balance::zero<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(),
            reserve_contribution_window_started_ms        : 0,
            reserve_contributed_this_window               : 0,
            reserve_contribution_cap_permanently_disabled : false,
        };
        (v0, v1)
    }

    public fun admin_renounce_withdrawals(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut Treasury, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.withdrawals_renounced, 4);
        assert!(arg1.initial_supply_deposited, 5);
        arg1.withdrawals_renounced = true;
        let v0 = TreasuryWithdrawalsRenounced{
            treasury_id : 0x2::object::id<Treasury>(arg1),
            admin       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TreasuryWithdrawalsRenounced>(v0);
    }

    public fun admin_withdraw(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.withdrawals_renounced, 1);
        assert!(arg2 > 0, 2);
        assert!(arg2 <= 0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg1.balance), 3);
        let v0 = TreasuryWithdrawn{
            treasury_object_id     : 0x2::object::id<Treasury>(arg1),
            recipient              : arg3,
            amount                 : arg2,
            treasury_balance_after : 0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg1.balance),
        };
        0x2::event::emit<TreasuryWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(0x2::coin::take<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg1.balance, arg2, arg4), arg3);
    }

    public(friend) fun calculate_game_reserve_route_for_supply(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        let v0 = reserve_contribution_dynamic_cap(arg0);
        let (v1, v2) = if (arg1 >= 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::reserve_contribution_cap_disable_supply()) {
            (arg3, 0)
        } else {
            let v3 = (((v0 as u128) + 18446744073709551616 - (arg2 as u128) >> 64) as u64);
            let v4 = v0 * v3 - arg2 * v3;
            let v5 = (((v4 as u128) + 18446744073709551616 - (arg3 as u128) >> 64) as u64);
            let v6 = arg3 * v5 + v4 * (1 - v5);
            (v6, arg3 - v6)
        };
        (v1, v2, v0)
    }

    public fun deposit_fee_with_cap(arg0: &mut Treasury, arg1: &mut PrizeReserve, arg2: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = route_raffle_fee(arg0, 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg2));
        if (v0 > 0) {
            deposit_treasury(arg0, 0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg2, v0, arg3));
        };
        if (v1 > 0) {
            deposit_reserve(arg1, 0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg2, v1, arg3));
        };
        0x2::coin::destroy_zero<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(arg2);
    }

    public fun deposit_reserve(arg0: &mut PrizeReserve, arg1: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>) {
        0x2::coin::put<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg0.balance, arg1);
    }

    public fun deposit_treasury(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>) {
        0x2::coin::put<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg0.balance, arg1);
    }

    public fun initial_supply_deposited(arg0: &Treasury) : bool {
        arg0.initial_supply_deposited
    }

    public(friend) fun mark_initial_supply_deposited(arg0: &mut Treasury) {
        arg0.initial_supply_deposited = true;
    }

    public fun remaining_treasury_capacity(arg0: &Treasury) : u64 {
        if (0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg0.balance) >= 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::treasury_cap()) {
            0
        } else {
            0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::treasury_cap() - 0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg0.balance)
        }
    }

    public fun reserve_balance(arg0: &PrizeReserve) : u64 {
        0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg0.balance)
    }

    public fun reserve_contributed_this_window(arg0: &PrizeReserve) : u64 {
        arg0.reserve_contributed_this_window
    }

    public fun reserve_contribution_cap_permanently_disabled(arg0: &PrizeReserve) : bool {
        arg0.reserve_contribution_cap_permanently_disabled
    }

    public fun reserve_contribution_dynamic_cap(arg0: u64) : u64 {
        (((arg0 as u128) * (0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::reserve_contribution_cap_bps() as u128) / (0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::bps_denominator() as u128)) as u64)
    }

    public fun reserve_contribution_window_started_ms(arg0: &PrizeReserve) : u64 {
        arg0.reserve_contribution_window_started_ms
    }

    public fun route_game_reserve_contribution<T0: drop>(arg0: T0, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut PrizeReserve, arg3: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: u64, arg5: 0x2::balance::Balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg6: &0x2::clock::Clock) : (u64, 0x2::balance::Balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<T0>(arg1);
        route_game_reserve_contribution_internal(arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun route_game_reserve_contribution_internal(arg0: &mut PrizeReserve, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg2: u64, arg3: 0x2::balance::Balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg4: &0x2::clock::Clock) : (u64, 0x2::balance::Balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>) {
        let v0 = 0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg3);
        let v1 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::total_supply(arg1);
        if (!arg0.reserve_contribution_cap_permanently_disabled && arg2 >= 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::reserve_contribution_cap_disable_supply()) {
            arg0.reserve_contribution_cap_permanently_disabled = true;
        };
        let v2 = arg0.reserve_contribution_cap_permanently_disabled;
        let v3 = arg0.reserve_contribution_window_started_ms;
        let v4 = v3;
        let v5 = arg0.reserve_contributed_this_window;
        let v6 = v5;
        let (v7, v8, v9, v10) = if (v2) {
            0x2::balance::join<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg0.balance, arg3);
            arg3 = 0x2::balance::zero<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>();
            (0, v5, reserve_contribution_dynamic_cap(v1), v0)
        } else {
            let v11 = 0x2::clock::timestamp_ms(arg4);
            if (v3 == 0 && arg0.reserve_contributed_this_window == 0 || v11 >= v3 + 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::reserve_contribution_window_ms()) {
                v4 = v11;
                arg0.reserve_contribution_window_started_ms = v11;
                arg0.reserve_contributed_this_window = 0;
                v6 = 0;
            };
            let (v12, v13, v14) = calculate_game_reserve_route_for_supply(v1, arg2, v6, v0);
            0x2::balance::join<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg0.balance, 0x2::balance::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg3, v12));
            arg0.reserve_contributed_this_window = v6 + v12;
            (v13, arg0.reserve_contributed_this_window, v14, v12)
        };
        let v15 = GameReserveContributionRouted{
            window_started_ms        : v4,
            current_supply           : v1,
            dynamic_cap              : v9,
            contributed_before       : v6,
            requested_reserve_amount : v0,
            sent_to_reserve          : v10,
            burned_excess            : v7,
            contributed_after        : v8,
            cap_disabled             : v2,
        };
        0x2::event::emit<GameReserveContributionRouted>(v15);
        (v10, arg3)
    }

    public fun route_raffle_fee(arg0: &mut Treasury, arg1: u64) : (u64, u64) {
        let v0 = if (arg1 <= remaining_treasury_capacity(arg0)) {
            arg1
        } else {
            remaining_treasury_capacity(arg0)
        };
        (v0, arg1 - v0)
    }

    public(friend) fun share_prize_reserve(arg0: PrizeReserve) {
        0x2::transfer::share_object<PrizeReserve>(arg0);
    }

    public(friend) fun share_treasury(arg0: Treasury) {
        0x2::transfer::share_object<Treasury>(arg0);
    }

    public(friend) fun take_for_game_credit_burn(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH> {
        assert!(arg1 > 0, 2);
        assert!(arg1 <= 0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg0.balance), 3);
        0x2::coin::take<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg0.balance, arg1, arg2)
    }

    public fun withdraw_reserve_up_to<T0: drop>(arg0: T0, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut PrizeReserve, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH> {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<T0>(arg1);
        withdraw_reserve_up_to_internal(arg2, arg3, arg4)
    }

    public(friend) fun withdraw_reserve_up_to_internal(arg0: &mut PrizeReserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH> {
        let v0 = if (arg1 <= 0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg0.balance)) {
            arg1
        } else {
            0x2::balance::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg0.balance)
        };
        0x2::coin::take<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg0.balance, v0, arg2)
    }

    public fun withdrawals_renounced(arg0: &Treasury) : bool {
        arg0.withdrawals_renounced
    }

    // decompiled from Move bytecode v7
}

