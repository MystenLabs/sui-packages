module 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::coin::TreasuryCap<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>,
        dead_shares: 0x2::balance::Balance<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>,
        open_escrow: u64,
        open_liability: u64,
        open_bets: u64,
        house_edge_bps: u64,
        max_bet_bps: u64,
        max_total_liability_bps: u64,
        min_bet: u64,
        paused: bool,
        referrers: 0x2::table::Table<address, address>,
        referral_rewards: 0x2::table::Table<address, u64>,
        owed_referrals: u64,
        referral_share_bps: u64,
    }

    struct Bet has store {
        pool_id: 0x2::object::ID,
        escrow: u64,
        max_win_net: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        pool_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        shares: u64,
        share_supply: u64,
        reserves: u64,
    }

    struct Withdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        withdrawer: address,
        shares: u64,
        amount: u64,
        share_supply: u64,
        reserves: u64,
    }

    struct ConfigUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        house_edge_bps: u64,
        max_bet_bps: u64,
        max_total_liability_bps: u64,
        min_bet: u64,
    }

    struct PausedSet has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
    }

    struct ReferrerBound has copy, drop {
        pool_id: 0x2::object::ID,
        player: address,
        referrer: address,
    }

    struct ReferralAccrued has copy, drop {
        pool_id: 0x2::object::ID,
        player: address,
        referrer: address,
        stake: u64,
        amount: u64,
        referrer_owed: u64,
        owed_referrals: u64,
    }

    struct ReferralClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        referrer: address,
        amount: u64,
        owed_referrals: u64,
    }

    struct ReferralConfigUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        referral_share_bps: u64,
    }

    fun accrue_referral(arg0: &mut Pool, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.referral_rewards, arg2)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referral_rewards, arg2);
            *v1 = *v1 + arg4;
            *v1
        } else {
            0x2::table::add<address, u64>(&mut arg0.referral_rewards, arg2, arg4);
            arg4
        };
        arg0.owed_referrals = arg0.owed_referrals + arg4;
        let v2 = ReferralAccrued{
            pool_id        : 0x2::object::id<Pool>(arg0),
            player         : arg1,
            referrer       : arg2,
            stake          : arg3,
            amount         : arg4,
            referrer_owed  : v0,
            owed_referrals : arg0.owed_referrals,
        };
        0x2::event::emit<ReferralAccrued>(v2);
    }

    public(friend) fun add_to_position(arg0: &mut Pool, arg1: &mut Bet, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: address, arg4: u64) {
        assert!(arg1.pool_id == 0x2::object::id<Pool>(arg0), 21);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 4);
        let v1 = referrer_of(arg0, arg3);
        let v2 = if (0x1::option::is_some<address>(&v1)) {
            referral_reward_for_edge(arg0, v0, arg4)
        } else {
            0
        };
        let v3 = house_capital(arg0);
        assert!((v3 as u128) >= (arg0.open_liability as u128) + (v2 as u128), 13);
        assert!((arg0.open_liability as u128) * (10000 as u128) <= ((v3 - v2) as u128) * (arg0.max_total_liability_bps as u128), 12);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserves, arg2);
        arg0.open_escrow = arg0.open_escrow + v0;
        arg1.escrow = arg1.escrow + v0;
        if (v2 > 0) {
            accrue_referral(arg0, arg3, 0x1::option::destroy_some<address>(v1), v0, v2);
        };
    }

    public fun admin_cap_pool_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.pool_id
    }

    fun assert_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 <= 500, 8);
        assert!(arg1 > 0 && arg1 <= 500, 8);
        assert!(arg2 >= 100 && arg2 <= 1500, 8);
        assert!(arg3 >= 1000000, 8);
    }

    public fun bet_escrow(arg0: &Bet) : u64 {
        arg0.escrow
    }

    public fun bet_max_win_net(arg0: &Bet) : u64 {
        arg0.max_win_net
    }

    public fun bet_pool_id(arg0: &Bet) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun bind_referrer(arg0: &mut Pool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 != v0, 17);
        assert!(arg1 != @0x0, 19);
        assert!(!0x2::table::contains<address, address>(&arg0.referrers, v0), 18);
        bind_unchecked(arg0, v0, arg1);
    }

    entry fun bind_referrer_entry(arg0: &mut Pool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        bind_referrer(arg0, arg1, arg2);
    }

    fun bind_unchecked(arg0: &mut Pool, arg1: address, arg2: address) {
        0x2::table::add<address, address>(&mut arg0.referrers, arg1, arg2);
        let v0 = ReferrerBound{
            pool_id  : 0x2::object::id<Pool>(arg0),
            player   : arg1,
            referrer : arg2,
        };
        0x2::event::emit<ReferrerBound>(v0);
    }

    public fun claim_referral_rewards(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.referral_rewards, v0), 20);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.referral_rewards, v0);
        assert!(v1 > 0, 20);
        arg0.owed_referrals = arg0.owed_referrals - v1;
        let v2 = ReferralClaimed{
            pool_id        : 0x2::object::id<Pool>(arg0),
            referrer       : v0,
            amount         : v1,
            owed_referrals : arg0.owed_referrals,
        };
        0x2::event::emit<ReferralClaimed>(v2);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.reserves, v1, arg1)
    }

    entry fun claim_referral_rewards_to_sender(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_referral_rewards(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create(arg0: 0x2::coin::TreasuryCap<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::coin::total_supply<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&arg0) == 0, 9);
        assert_config(arg1, arg2, arg3, arg4);
        let v0 = Pool{
            id                      : 0x2::object::new(arg5),
            reserves                : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury                : arg0,
            dead_shares             : 0x2::balance::zero<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(),
            open_escrow             : 0,
            open_liability          : 0,
            open_bets               : 0,
            house_edge_bps          : arg1,
            max_bet_bps             : arg2,
            max_total_liability_bps : arg3,
            min_bet                 : arg4,
            paused                  : false,
            referrers               : 0x2::table::new<address, address>(arg5),
            referral_rewards        : 0x2::table::new<address, u64>(arg5),
            owed_referrals          : 0,
            referral_share_bps      : 2000,
        };
        let v1 = 0x2::object::id<Pool>(&v0);
        let v2 = AdminCap{
            id      : 0x2::object::new(arg5),
            pool_id : v1,
        };
        let v3 = PoolCreated{
            pool_id      : v1,
            admin_cap_id : 0x2::object::id<AdminCap>(&v2),
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::transfer::share_object<Pool>(v0);
        v2
    }

    entry fun create_and_keep_cap(arg0: 0x2::coin::TreasuryCap<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun dead_shares(arg0: &Pool) : u64 {
        0x2::balance::value<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&arg0.dead_shares)
    }

    public fun deposit(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE> {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000, 1);
        let v1 = 0x2::coin::total_supply<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&arg0.treasury);
        let v2 = if (v1 == 0) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reserves) == 0, 16);
            assert!(v0 >= 1000000000, 2);
            0x2::balance::join<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&mut arg0.dead_shares, 0x2::coin::mint_balance<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&mut arg0.treasury, 1000000));
            v0 - 1000000
        } else {
            let v3 = deposit_nav(arg0);
            assert!(v3 > 0, 5);
            mul_div_down(v0, v1, v3)
        };
        assert!(v2 > 0, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserves, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v4 = Deposited{
            pool_id      : 0x2::object::id<Pool>(arg0),
            depositor    : 0x2::tx_context::sender(arg2),
            amount       : v0,
            shares       : v2,
            share_supply : 0x2::coin::total_supply<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&arg0.treasury),
            reserves     : 0x2::balance::value<0x2::sui::SUI>(&arg0.reserves),
        };
        0x2::event::emit<Deposited>(v4);
        0x2::coin::mint<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&mut arg0.treasury, v2, arg2)
    }

    public fun deposit_nav(arg0: &Pool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reserves) - arg0.owed_referrals
    }

    entry fun deposit_to_sender(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun house_capital(arg0: &Pool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reserves) - arg0.open_escrow - arg0.owed_referrals
    }

    public fun house_edge_bps(arg0: &Pool) : u64 {
        arg0.house_edge_bps
    }

    public fun is_paused(arg0: &Pool) : bool {
        arg0.paused
    }

    public fun max_bet(arg0: &Pool) : u64 {
        mul_div_down(house_capital(arg0), arg0.max_bet_bps, 10000)
    }

    public fun max_bet_bps(arg0: &Pool) : u64 {
        arg0.max_bet_bps
    }

    public fun max_referral_share_bps() : u64 {
        5000
    }

    public fun max_total_liability_bps(arg0: &Pool) : u64 {
        arg0.max_total_liability_bps
    }

    public fun min_bet(arg0: &Pool) : u64 {
        arg0.min_bet
    }

    fun mul_div_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 14);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 14);
        (v0 as u64)
    }

    public(friend) fun open_bet(arg0: &mut Pool, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: address) {
        let v0 = arg0.house_edge_bps;
        open_internal(arg0, arg1, arg2, arg3, v0);
    }

    public fun open_bets(arg0: &Pool) : u64 {
        arg0.open_bets
    }

    public fun open_escrow(arg0: &Pool) : u64 {
        arg0.open_escrow
    }

    fun open_internal(arg0: &mut Pool, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: u64) : u64 {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.min_bet, 10);
        let v1 = house_capital(arg0);
        assert!(v0 <= mul_div_down(v1, arg0.max_bet_bps, 10000), 11);
        let v2 = referrer_of(arg0, arg3);
        let v3 = if (0x1::option::is_some<address>(&v2)) {
            referral_reward_for_edge(arg0, v0, arg4)
        } else {
            0
        };
        let v4 = (arg0.open_liability as u128) + (arg2 as u128);
        assert!((v1 as u128) >= v4 + (v3 as u128), 13);
        assert!(v4 * (10000 as u128) <= ((v1 - v3) as u128) * (arg0.max_total_liability_bps as u128), 12);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserves, arg1);
        arg0.open_escrow = arg0.open_escrow + v0;
        arg0.open_liability = (v4 as u64);
        arg0.open_bets = arg0.open_bets + 1;
        if (v3 > 0) {
            accrue_referral(arg0, arg3, 0x1::option::destroy_some<address>(v2), v0, v3);
        };
        v0
    }

    public fun open_liability(arg0: &Pool) : u64 {
        arg0.open_liability
    }

    public(friend) fun open_position(arg0: &mut Pool, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: u64) : Bet {
        let v0 = open_internal(arg0, arg1, arg2, arg3, arg4);
        Bet{
            pool_id     : 0x2::object::id<Pool>(arg0),
            escrow      : v0,
            max_win_net : arg2,
        }
    }

    public fun owed_referrals(arg0: &Pool) : u64 {
        arg0.owed_referrals
    }

    public fun preview_deposit(arg0: &Pool, arg1: u64) : u64 {
        let v0 = 0x2::coin::total_supply<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&arg0.treasury);
        if (v0 == 0) {
            if (arg1 >= 1000000000) {
                arg1 - 1000000
            } else {
                0
            }
        } else {
            let v2 = deposit_nav(arg0);
            if (v2 == 0) {
                0
            } else {
                mul_div_down(arg1, v0, v2)
            }
        }
    }

    public fun preview_withdraw(arg0: &Pool, arg1: u64) : u64 {
        let v0 = 0x2::coin::total_supply<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&arg0.treasury);
        if (v0 == 0) {
            0
        } else {
            mul_div_down(arg1, withdraw_nav(arg0), v0)
        }
    }

    public fun referral_reward(arg0: &Pool, arg1: u64) : u64 {
        referral_reward_for_edge(arg0, arg1, arg0.house_edge_bps)
    }

    public fun referral_reward_for_edge(arg0: &Pool, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg2 > 500) {
            500
        } else {
            arg2
        };
        (((arg1 as u128) * (v0 as u128) * (arg0.referral_share_bps as u128) / (10000 as u128) * (10000 as u128)) as u64)
    }

    public fun referral_rewards_of(arg0: &Pool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.referral_rewards, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.referral_rewards, arg1)
        } else {
            0
        }
    }

    public fun referral_share_bps(arg0: &Pool) : u64 {
        arg0.referral_share_bps
    }

    public fun referrer_of(arg0: &Pool, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.referrers, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referrers, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun reserves(arg0: &Pool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reserves)
    }

    public fun set_config(arg0: &mut Pool, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg1.pool_id == 0x2::object::id<Pool>(arg0), 7);
        assert_config(arg2, arg3, arg4, arg5);
        arg0.house_edge_bps = arg2;
        arg0.max_bet_bps = arg3;
        arg0.max_total_liability_bps = arg4;
        arg0.min_bet = arg5;
        let v0 = ConfigUpdated{
            pool_id                 : 0x2::object::id<Pool>(arg0),
            house_edge_bps          : arg2,
            max_bet_bps             : arg3,
            max_total_liability_bps : arg4,
            min_bet                 : arg5,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_paused(arg0: &mut Pool, arg1: &AdminCap, arg2: bool) {
        assert!(arg1.pool_id == 0x2::object::id<Pool>(arg0), 7);
        arg0.paused = arg2;
        let v0 = PausedSet{
            pool_id : 0x2::object::id<Pool>(arg0),
            paused  : arg2,
        };
        0x2::event::emit<PausedSet>(v0);
    }

    public fun set_referral_share_bps(arg0: &mut Pool, arg1: &AdminCap, arg2: u64) {
        assert!(arg1.pool_id == 0x2::object::id<Pool>(arg0), 7);
        assert!(arg2 <= 5000, 8);
        arg0.referral_share_bps = arg2;
        let v0 = ReferralConfigUpdated{
            pool_id            : 0x2::object::id<Pool>(arg0),
            referral_share_bps : arg2,
        };
        0x2::event::emit<ReferralConfigUpdated>(v0);
    }

    public(friend) fun settle_bet(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        settle_internal(arg0, arg1, arg2, arg3)
    }

    fun settle_internal(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!((arg3 as u128) <= (arg1 as u128) + (arg2 as u128), 15);
        arg0.open_escrow = arg0.open_escrow - arg1;
        arg0.open_liability = arg0.open_liability - arg2;
        arg0.open_bets = arg0.open_bets - 1;
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserves, arg3)
    }

    public(friend) fun settle_position(arg0: &mut Pool, arg1: Bet, arg2: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        let Bet {
            pool_id     : v0,
            escrow      : v1,
            max_win_net : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<Pool>(arg0), 21);
        settle_internal(arg0, v1, v2, arg2)
    }

    public fun share_supply(arg0: &Pool) : u64 {
        0x2::coin::total_supply<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&arg0.treasury)
    }

    public(friend) fun try_bind_referrer(arg0: &mut Pool, arg1: address, arg2: address) : bool {
        let v0 = if (arg2 == arg1) {
            true
        } else if (arg2 == @0x0) {
            true
        } else {
            0x2::table::contains<address, address>(&arg0.referrers, arg1)
        };
        if (v0) {
            return false
        };
        bind_unchecked(arg0, arg1, arg2);
        true
    }

    public(friend) fun uid(arg0: &Pool) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Pool) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun win_payout(arg0: &Pool, arg1: u64) : u64 {
        mul_div_down(arg1 * 2, 10000 - arg0.house_edge_bps, 10000)
    }

    public fun withdraw(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = withdraw_nav(arg0);
        assert!(v1 > 0, 5);
        let v2 = mul_div_down(v0, v1, 0x2::coin::total_supply<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&arg0.treasury));
        assert!(v2 > 0, 4);
        assert!((arg0.open_liability as u128) * (10000 as u128) <= ((house_capital(arg0) - v2) as u128) * (arg0.max_total_liability_bps as u128), 6);
        0x2::coin::burn<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&mut arg0.treasury, arg1);
        let v3 = Withdrawn{
            pool_id      : 0x2::object::id<Pool>(arg0),
            withdrawer   : 0x2::tx_context::sender(arg2),
            shares       : v0,
            amount       : v2,
            share_supply : 0x2::coin::total_supply<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>(&arg0.treasury),
            reserves     : 0x2::balance::value<0x2::sui::SUI>(&arg0.reserves),
        };
        0x2::event::emit<Withdrawn>(v3);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.reserves, v2, arg2)
    }

    public fun withdraw_nav(arg0: &Pool) : u64 {
        let v0 = house_capital(arg0);
        if (v0 > arg0.open_liability) {
            v0 - arg0.open_liability
        } else {
            0
        }
    }

    entry fun withdraw_to_sender(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::share::SHARE>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

