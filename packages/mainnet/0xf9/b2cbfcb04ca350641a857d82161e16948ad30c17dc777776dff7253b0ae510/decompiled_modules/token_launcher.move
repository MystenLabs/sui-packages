module 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher {
    struct Configuration has copy, store {
        version: u64,
        platform_fee_bps: u64,
        creation_fee: u64,
        graduation_fee: u64,
        initial_virtual_sui: u64,
        initial_virtual_tokens: u64,
        token_decimals: u8,
        graduation_threshold: u64,
        bonding_curve_bps: u64,
        amm_reserve_bps: u64,
        graduated_swap_fee_bps: u64,
        min_graduation_sui_liquidity: u64,
        max_price_deviation_bps: u64,
        min_token_utilization_bps: u64,
    }

    struct WithdrawalSecurity has store {
        last_withdrawal_time: u64,
        max_withdrawal_amount: u64,
        withdrawal_delay_ms: u64,
    }

    struct Launchpad has store, key {
        id: 0x2::object::UID,
        admin: address,
        launched_coins_count: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        config: Configuration,
        withdrawal_security: WithdrawalSecurity,
        emergency_paused: bool,
    }

    struct LaunchedCoinsRegistry has key {
        id: 0x2::object::UID,
        coins: vector<address>,
    }

    struct LaunchpadInitializedEvent has copy, drop {
        admin: address,
        launchpad_address: address,
        initial_virtual_sui: u64,
        initial_virtual_tokens: u64,
        token_decimals: u8,
        bonding_curve_bps: u64,
        amm_reserve_bps: u64,
        graduated_swap_fee_bps: u64,
        graduation_threshold: u64,
        creation_fee: u64,
        graduation_fee: u64,
        platform_fee_bps: u64,
    }

    struct ConfigurationUpdatedEvent has copy, drop {
        old_version: u64,
        old_platform_fee_bps: u64,
        old_creation_fee: u64,
        old_graduation_threshold: u64,
        old_graduation_fee: u64,
        old_initial_virtual_sui: u64,
        old_initial_virtual_tokens: u64,
        old_token_decimals: u8,
        old_bonding_curve_bps: u64,
        old_amm_reserve_bps: u64,
        old_graduated_swap_fee_bps: u64,
        old_min_graduation_sui_liquidity: u64,
        old_max_price_deviation_bps: u64,
        old_min_token_utilization_bps: u64,
        new_version: u64,
        new_platform_fee_bps: u64,
        new_creation_fee: u64,
        new_graduation_threshold: u64,
        new_graduation_fee: u64,
        new_initial_virtual_sui: u64,
        new_initial_virtual_tokens: u64,
        new_token_decimals: u8,
        new_bonding_curve_bps: u64,
        new_amm_reserve_bps: u64,
        new_graduated_swap_fee_bps: u64,
        new_min_graduation_sui_liquidity: u64,
        new_max_price_deviation_bps: u64,
        new_min_token_utilization_bps: u64,
    }

    struct WithdrawalSecurityUpdatedEvent has copy, drop {
        admin: address,
        old_max_withdrawal_amount: u64,
        old_withdrawal_delay_ms: u64,
        new_max_withdrawal_amount: u64,
        new_withdrawal_delay_ms: u64,
        timestamp: u64,
    }

    struct TreasuryWithdrawalEvent has copy, drop {
        admin: address,
        amount: u64,
        recipient: address,
        treasury_balance_after: u64,
        timestamp: u64,
        next_withdrawal_allowed_at: u64,
    }

    struct EmergencyPauseEvent has copy, drop {
        admin: address,
        paused: bool,
        timestamp: u64,
        reason: 0x1::string::String,
    }

    public fun add_to_registry(arg0: &mut LaunchedCoinsRegistry, arg1: address) {
        0x1::vector::push_back<address>(&mut arg0.coins, arg1);
    }

    public fun add_to_treasury(arg0: &mut Launchpad, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, arg1);
    }

    public fun calculate_amm_reserve_tokens(arg0: &Launchpad) : u64 {
        arg0.config.initial_virtual_tokens * arg0.config.amm_reserve_bps / 10000
    }

    public fun calculate_bonding_curve_tokens(arg0: &Launchpad) : u64 {
        arg0.config.initial_virtual_tokens * arg0.config.bonding_curve_bps / 10000
    }

    public entry fun emergency_pause(arg0: &mut Launchpad, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 0);
        arg0.emergency_paused = true;
        let v0 = EmergencyPauseEvent{
            admin     : 0x2::tx_context::sender(arg3),
            paused    : true,
            timestamp : 0x2::clock::timestamp_ms(arg2),
            reason    : 0x1::string::utf8(arg1),
        };
        0x2::event::emit<EmergencyPauseEvent>(v0);
    }

    public entry fun emergency_unpause(arg0: &mut Launchpad, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 0);
        arg0.emergency_paused = false;
        let v0 = EmergencyPauseEvent{
            admin     : 0x2::tx_context::sender(arg3),
            paused    : false,
            timestamp : 0x2::clock::timestamp_ms(arg2),
            reason    : 0x1::string::utf8(arg1),
        };
        0x2::event::emit<EmergencyPauseEvent>(v0);
    }

    public fun get_admin(arg0: &Launchpad) : address {
        arg0.admin
    }

    public fun get_amm_reserve_bps(arg0: &Launchpad) : u64 {
        arg0.config.amm_reserve_bps
    }

    public fun get_bonding_curve_bps(arg0: &Launchpad) : u64 {
        arg0.config.bonding_curve_bps
    }

    public fun get_creation_fee(arg0: &Launchpad) : u64 {
        arg0.config.creation_fee
    }

    public fun get_graduated_swap_fee_bps(arg0: &Launchpad) : u64 {
        arg0.config.graduated_swap_fee_bps
    }

    public fun get_graduation_fee(arg0: &Launchpad) : u64 {
        arg0.config.graduation_fee
    }

    public fun get_graduation_threshold(arg0: &Launchpad) : u64 {
        arg0.config.graduation_threshold
    }

    public fun get_initial_virtual_sui(arg0: &Launchpad) : u64 {
        arg0.config.initial_virtual_sui
    }

    public fun get_initial_virtual_tokens(arg0: &Launchpad) : u64 {
        arg0.config.initial_virtual_tokens
    }

    public fun get_last_withdrawal_time(arg0: &Launchpad) : u64 {
        arg0.withdrawal_security.last_withdrawal_time
    }

    public fun get_launched_coins(arg0: &LaunchedCoinsRegistry) : vector<address> {
        arg0.coins
    }

    public fun get_launched_coins_count(arg0: &Launchpad) : u64 {
        arg0.launched_coins_count
    }

    public fun get_max_price_deviation_bps(arg0: &Launchpad) : u64 {
        arg0.config.max_price_deviation_bps
    }

    public fun get_max_withdrawal_amount(arg0: &Launchpad) : u64 {
        arg0.withdrawal_security.max_withdrawal_amount
    }

    public fun get_min_graduation_sui_liquidity(arg0: &Launchpad) : u64 {
        arg0.config.min_graduation_sui_liquidity
    }

    public fun get_min_token_utilization_bps(arg0: &Launchpad) : u64 {
        arg0.config.min_token_utilization_bps
    }

    public fun get_platform_fee_bps(arg0: &Launchpad) : u64 {
        arg0.config.platform_fee_bps
    }

    public fun get_time_until_next_withdrawal(arg0: &Launchpad, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.withdrawal_security.last_withdrawal_time;
        if (v0 >= arg0.withdrawal_security.withdrawal_delay_ms) {
            0
        } else {
            arg0.withdrawal_security.withdrawal_delay_ms - v0
        }
    }

    public fun get_token_decimals(arg0: &Launchpad) : u8 {
        arg0.config.token_decimals
    }

    public fun get_version(arg0: &Launchpad) : u64 {
        arg0.config.version
    }

    public fun get_withdrawal_delay_ms(arg0: &Launchpad) : u64 {
        arg0.withdrawal_security.withdrawal_delay_ms
    }

    public fun increment_coins_count(arg0: &mut Launchpad) {
        arg0.launched_coins_count = arg0.launched_coins_count + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            version                      : 1,
            platform_fee_bps             : 100,
            creation_fee                 : 1000000000,
            graduation_fee               : 60000000000,
            initial_virtual_sui          : 1500000000000,
            initial_virtual_tokens       : 1000000000000000,
            token_decimals               : 6,
            graduation_threshold         : 3000000000000,
            bonding_curve_bps            : 8000,
            amm_reserve_bps              : 2000,
            graduated_swap_fee_bps       : 25,
            min_graduation_sui_liquidity : 2000000000000,
            max_price_deviation_bps      : 1500,
            min_token_utilization_bps    : 2000,
        };
        let v1 = WithdrawalSecurity{
            last_withdrawal_time  : 0,
            max_withdrawal_amount : 100000000000,
            withdrawal_delay_ms   : 21600000,
        };
        let v2 = Launchpad{
            id                   : 0x2::object::new(arg0),
            admin                : 0x2::tx_context::sender(arg0),
            launched_coins_count : 0,
            treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            config               : v0,
            withdrawal_security  : v1,
            emergency_paused     : false,
        };
        let v3 = 0x2::object::id<Launchpad>(&v2);
        let v4 = LaunchedCoinsRegistry{
            id    : 0x2::object::new(arg0),
            coins : 0x1::vector::empty<address>(),
        };
        let v5 = LaunchpadInitializedEvent{
            admin                  : 0x2::tx_context::sender(arg0),
            launchpad_address      : 0x2::object::id_to_address(&v3),
            initial_virtual_sui    : v0.initial_virtual_sui,
            initial_virtual_tokens : v0.initial_virtual_tokens,
            token_decimals         : v0.token_decimals,
            bonding_curve_bps      : v0.bonding_curve_bps,
            amm_reserve_bps        : v0.amm_reserve_bps,
            graduated_swap_fee_bps : v0.graduated_swap_fee_bps,
            graduation_threshold   : v0.graduation_threshold,
            creation_fee           : v0.creation_fee,
            graduation_fee         : v0.graduation_fee,
            platform_fee_bps       : v0.platform_fee_bps,
        };
        0x2::event::emit<LaunchpadInitializedEvent>(v5);
        0x2::transfer::public_share_object<Launchpad>(v2);
        0x2::transfer::share_object<LaunchedCoinsRegistry>(v4);
    }

    public fun is_emergency_paused(arg0: &Launchpad) : bool {
        arg0.emergency_paused
    }

    public entry fun update_launchpad_admin(arg0: &mut Launchpad, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.admin = arg1;
    }

    public entry fun update_launchpad_config(arg0: &mut Launchpad, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg15), 0);
        assert!(arg9 + arg10 == 10000, 2);
        arg0.config.version = arg1;
        arg0.config.platform_fee_bps = arg2;
        arg0.config.creation_fee = arg3;
        arg0.config.graduation_threshold = arg4;
        arg0.config.graduation_fee = arg5;
        arg0.config.initial_virtual_sui = arg6;
        arg0.config.initial_virtual_tokens = arg7;
        arg0.config.token_decimals = arg8;
        arg0.config.bonding_curve_bps = arg9;
        arg0.config.amm_reserve_bps = arg10;
        arg0.config.graduated_swap_fee_bps = arg11;
        arg0.config.min_graduation_sui_liquidity = arg12;
        arg0.config.max_price_deviation_bps = arg13;
        arg0.config.min_token_utilization_bps = arg14;
        let v0 = ConfigurationUpdatedEvent{
            old_version                      : arg0.config.version,
            old_platform_fee_bps             : arg0.config.platform_fee_bps,
            old_creation_fee                 : arg0.config.creation_fee,
            old_graduation_threshold         : arg0.config.graduation_threshold,
            old_graduation_fee               : arg0.config.graduation_fee,
            old_initial_virtual_sui          : arg0.config.initial_virtual_sui,
            old_initial_virtual_tokens       : arg0.config.initial_virtual_tokens,
            old_token_decimals               : arg0.config.token_decimals,
            old_bonding_curve_bps            : arg0.config.bonding_curve_bps,
            old_amm_reserve_bps              : arg0.config.amm_reserve_bps,
            old_graduated_swap_fee_bps       : arg0.config.graduated_swap_fee_bps,
            old_min_graduation_sui_liquidity : arg0.config.min_graduation_sui_liquidity,
            old_max_price_deviation_bps      : arg0.config.max_price_deviation_bps,
            old_min_token_utilization_bps    : arg0.config.min_token_utilization_bps,
            new_version                      : arg1,
            new_platform_fee_bps             : arg2,
            new_creation_fee                 : arg3,
            new_graduation_threshold         : arg4,
            new_graduation_fee               : arg5,
            new_initial_virtual_sui          : arg6,
            new_initial_virtual_tokens       : arg7,
            new_token_decimals               : arg8,
            new_bonding_curve_bps            : arg9,
            new_amm_reserve_bps              : arg10,
            new_graduated_swap_fee_bps       : arg11,
            new_min_graduation_sui_liquidity : arg12,
            new_max_price_deviation_bps      : arg13,
            new_min_token_utilization_bps    : arg14,
        };
        0x2::event::emit<ConfigurationUpdatedEvent>(v0);
    }

    public entry fun update_withdrawal_security(arg0: &mut Launchpad, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.admin == v0, 0);
        arg0.withdrawal_security.max_withdrawal_amount = arg1;
        arg0.withdrawal_security.withdrawal_delay_ms = arg2;
        let v1 = WithdrawalSecurityUpdatedEvent{
            admin                     : v0,
            old_max_withdrawal_amount : arg0.withdrawal_security.max_withdrawal_amount,
            old_withdrawal_delay_ms   : arg0.withdrawal_security.withdrawal_delay_ms,
            new_max_withdrawal_amount : arg1,
            new_withdrawal_delay_ms   : arg2,
            timestamp                 : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WithdrawalSecurityUpdatedEvent>(v1);
    }

    public entry fun withdraw_treasury(arg0: &mut Launchpad, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.admin == v0, 0);
        assert!(arg1 <= arg0.withdrawal_security.max_withdrawal_amount, 3);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 - arg0.withdrawal_security.last_withdrawal_time >= arg0.withdrawal_security.withdrawal_delay_ms, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= arg1, 1);
        arg0.withdrawal_security.last_withdrawal_time = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, arg1), arg4), arg2);
        let v2 = TreasuryWithdrawalEvent{
            admin                      : v0,
            amount                     : arg1,
            recipient                  : arg2,
            treasury_balance_after     : 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury),
            timestamp                  : v1,
            next_withdrawal_allowed_at : v1 + arg0.withdrawal_security.withdrawal_delay_ms,
        };
        0x2::event::emit<TreasuryWithdrawalEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

