module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter {
    struct MINTER has drop {
        dummy_field: bool,
    }

    struct MintRewards has copy, drop {
        gauge_rewards: u64,
        rebase_rewards: u64,
        timestamp: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Minter has key {
        id: 0x2::object::UID,
        is_first_mint: bool,
        is_started: bool,
        decay_rate: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::Int128,
        inflation_period_count: u64,
        weekly: u64,
        active_period: u64,
        last_inflation_period: u64,
        mint_cap: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::MintCap,
        treasury: 0x2::balance::Balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>,
    }

    public fun active_period(arg0: &Minter) : u64 {
        arg0.active_period
    }

    public fun calculate_emission(arg0: &Minter) : u64 {
        calculate_emission_(arg0)
    }

    fun calculate_emission_(arg0: &Minter) : u64 {
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::to_u64(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::add(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::from_u64(arg0.weekly), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::div_u64(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::mul(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::from_u64(arg0.weekly), arg0.decay_rate), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::PRECISSION())))
    }

    public fun calculate_growth(arg0: &Minter, arg1: u64, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::VotingEscrowManager, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::vesting_factory::VestingFactory, arg4: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::MintManager) : u64 {
        calculate_growth_(arg0, arg1, arg2, arg3, arg4)
    }

    fun calculate_growth_(arg0: &Minter, arg1: u64, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::VotingEscrowManager, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::vesting_factory::VestingFactory, arg4: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::MintManager) : u64 {
        let v0 = (0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::total_supply_at_t(arg2, arg0.active_period - 1000) as u256);
        let v1 = ((0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::total_supply(arg4) - 0x2::balance::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&arg0.treasury) - 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::vesting_factory::total_vested(arg3)) as u256);
        if (v1 == 0) {
            return 0
        };
        (((arg1 as u256) * (v1 - v0) / v1 * (v1 - v0) / v1 / 2) as u64)
    }

    public fun emissions_balance(arg0: &Minter) : u64 {
        0x2::balance::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&arg0.treasury)
    }

    fun init(arg0: MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Minter{
            id                     : 0x2::object::new(arg1),
            is_first_mint          : true,
            is_started             : false,
            decay_rate             : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::negate(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::from_u64(500)),
            inflation_period_count : 12,
            weekly                 : 1800000 * 0x1::u64::pow(10, 9),
            active_period          : 0,
            last_inflation_period  : 0,
            mint_cap               : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::create_mint_cap_(arg1),
            treasury               : 0x2::balance::zero<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Minter>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut Minter, arg1: u64, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::MintManager, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&mut arg0.treasury, 0x2::coin::into_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::mint_with_cap(arg2, &arg0.mint_cap, arg1, arg4)));
    }

    public fun next_epoch_start(arg0: &Minter) : u64 {
        active_period(arg0) + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK()
    }

    public fun period(arg0: u64) : u64 {
        arg0 / 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK()
    }

    entry fun set_decay_rate(arg0: &mut Minter, arg1: u64, arg2: bool, arg3: &AdminCap) {
        let v0 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::from_u64(arg1);
        let v1 = v0;
        if (arg2) {
            v1 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::negate(v0);
        };
        arg0.decay_rate = v1;
    }

    entry fun set_weekly(arg0: &mut Minter, arg1: u64, arg2: &AdminCap) {
        arg0.weekly = arg1;
    }

    public fun start(arg0: &mut Minter, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert!(!arg0.is_started, 13906834530825666559);
        arg0.is_started = true;
        arg0.active_period = 0x2::clock::timestamp_ms(arg2) / 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
        arg0.last_inflation_period = arg0.active_period + arg0.inflation_period_count * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
    }

    public(friend) fun update_period(arg0: &mut Minter, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::VotingEscrowManager, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::vesting_factory::VestingFactory, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::MintManager, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>, 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>) {
        update_period_(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun update_period_(arg0: &mut Minter, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::VotingEscrowManager, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::vesting_factory::VestingFactory, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::MintManager, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>, 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (v0 >= arg0.active_period + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() && arg0.is_started) {
            arg0.active_period = v0 / 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
            if (arg0.active_period == arg0.last_inflation_period) {
                arg0.decay_rate = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::zero();
                arg0.weekly = 1050000000000000;
            };
            if (!arg0.is_first_mint) {
                arg0.weekly = weekly_emission(arg0);
            } else {
                arg0.is_first_mint = false;
            };
            let v3 = arg0.weekly;
            let v4 = calculate_growth(arg0, v3, arg1, arg2, arg3);
            let v5 = 0x2::coin::from_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(0x2::balance::split<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&mut arg0.treasury, v4), arg5);
            let v6 = 0x2::coin::from_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(0x2::balance::split<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&mut arg0.treasury, v3 - v4), arg5);
            let v7 = MintRewards{
                gauge_rewards  : 0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&v6),
                rebase_rewards : 0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&v5),
                timestamp      : v0,
            };
            0x2::event::emit<MintRewards>(v7);
            (v5, v6)
        } else {
            (0x2::coin::zero<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(arg5), 0x2::coin::zero<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(arg5))
        }
    }

    public fun weekly_emission(arg0: &Minter) : u64 {
        calculate_emission(arg0)
    }

    // decompiled from Move bytecode v6
}

