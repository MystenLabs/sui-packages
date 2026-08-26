module 0x1e5576631e7cb1e2168e0be3395de3fdb700053745e741129031098ae9ca553d::dslvr {
    struct DSLVR has drop {
        dummy_field: bool,
    }

    struct RewardCap has store, key {
        id: 0x2::object::UID,
    }

    struct AllocationAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchVault has key {
        id: 0x2::object::UID,
        configured: bool,
        launch_at_ms: u64,
        treasury_recipient: address,
        team_recipient: address,
        staking_recipient: address,
        liquidity: 0x2::balance::Balance<DSLVR>,
        treasury: 0x2::balance::Balance<DSLVR>,
        staking: 0x2::balance::Balance<DSLVR>,
        team: 0x2::balance::Balance<DSLVR>,
        presale: 0x2::balance::Balance<DSLVR>,
        liquidity_withdrawn: bool,
        presale_withdrawn: bool,
        treasury_claimed: u64,
        staking_claimed: u64,
        team_claimed: u64,
    }

    struct UnrefinedPosition has store {
        owner: address,
        amount: u64,
        awarded_at_ms: u64,
        matures_at_ms: u64,
        claimed: bool,
    }

    struct Refinery has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<DSLVR>,
        reward_cap_id: 0x2::object::ID,
        awarded: u64,
        minted: u64,
        forfeited: u64,
        positions: vector<UnrefinedPosition>,
    }

    struct RewardAwarded has copy, drop {
        owner: address,
        amount: u64,
        matures_at_ms: u64,
    }

    struct RefinedClaimed has copy, drop {
        owner: address,
        amount: u64,
    }

    struct EarlyClaimed has copy, drop {
        owner: address,
        gross: u64,
        received: u64,
        penalty: u64,
    }

    fun assert_launched(arg0: &LaunchVault, arg1: &0x2::clock::Clock) {
        assert!(arg0.configured, 7);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.launch_at_ms, 9);
    }

    public(friend) fun award_from_game(arg0: &mut Refinery, arg1: &RewardCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(0x2::object::id<RewardCap>(arg1) == arg0.reward_cap_id, 1);
        assert!(arg3 > 0, 2);
        assert!(arg0.awarded <= 3000000000000 - arg3, 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = v0 + 86400000;
        arg0.awarded = arg0.awarded + arg3;
        let v2 = UnrefinedPosition{
            owner         : arg2,
            amount        : arg3,
            awarded_at_ms : v0,
            matures_at_ms : v1,
            claimed       : false,
        };
        0x1::vector::push_back<UnrefinedPosition>(&mut arg0.positions, v2);
        let v3 = RewardAwarded{
            owner         : arg2,
            amount        : arg3,
            matures_at_ms : v1,
        };
        0x2::event::emit<RewardAwarded>(v3);
    }

    public fun awarded(arg0: &Refinery) : u64 {
        arg0.awarded
    }

    public fun claim_early(arg0: &mut Refinery, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<UnrefinedPosition>(&arg0.positions) && !v1) {
            let v4 = 0x1::vector::borrow_mut<UnrefinedPosition>(&mut arg0.positions, v3);
            let v5 = if (v4.owner == v0) {
                if (!v4.claimed) {
                    0x2::clock::timestamp_ms(arg1) < v4.matures_at_ms
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                v4.claimed = true;
                v2 = v4.amount;
                v1 = true;
            };
            v3 = v3 + 1;
        };
        assert!(v1, 5);
        assert!(v2 > 0, 6);
        let v6 = mul_div(v2, 1000, 10000);
        let v7 = v2 - v6;
        arg0.minted = arg0.minted + v7;
        arg0.forfeited = arg0.forfeited + v6;
        0x2::transfer::public_transfer<0x2::coin::Coin<DSLVR>>(0x2::coin::mint<DSLVR>(&mut arg0.treasury, v7, arg2), v0);
        let v8 = EarlyClaimed{
            owner    : v0,
            gross    : v2,
            received : v7,
            penalty  : v6,
        };
        0x2::event::emit<EarlyClaimed>(v8);
    }

    public fun claim_refined(arg0: &mut Refinery, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<UnrefinedPosition>(&arg0.positions) && !v1) {
            let v4 = 0x1::vector::borrow_mut<UnrefinedPosition>(&mut arg0.positions, v3);
            let v5 = if (v4.owner == v0) {
                if (!v4.claimed) {
                    0x2::clock::timestamp_ms(arg1) >= v4.matures_at_ms
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                v4.claimed = true;
                v2 = v4.amount;
                v1 = true;
            };
            v3 = v3 + 1;
        };
        assert!(v1, 5);
        arg0.minted = arg0.minted + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<DSLVR>>(0x2::coin::mint<DSLVR>(&mut arg0.treasury, v2, arg2), v0);
        let v6 = RefinedClaimed{
            owner  : v0,
            amount : v2,
        };
        0x2::event::emit<RefinedClaimed>(v6);
    }

    public fun claim_staking(arg0: &mut LaunchVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_launched(arg0, arg1);
        let v0 = monthly_vested(350000000000, 0x2::clock::timestamp_ms(arg1) - arg0.launch_at_ms, 36);
        let v1 = v0 - arg0.staking_claimed;
        assert!(v1 > 0, 10);
        arg0.staking_claimed = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DSLVR>>(0x2::coin::from_balance<DSLVR>(0x2::balance::split<DSLVR>(&mut arg0.staking, v1), arg2), arg0.staking_recipient);
    }

    public fun claim_team(arg0: &mut LaunchVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_launched(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.launch_at_ms;
        assert!(v0 >= 31104000000, 10);
        let v1 = monthly_vested(250000000000, v0 - 31104000000, 24);
        let v2 = v1 - arg0.team_claimed;
        assert!(v2 > 0, 10);
        arg0.team_claimed = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<DSLVR>>(0x2::coin::from_balance<DSLVR>(0x2::balance::split<DSLVR>(&mut arg0.team, v2), arg2), arg0.team_recipient);
    }

    public fun claim_treasury(arg0: &mut LaunchVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_launched(arg0, arg1);
        let v0 = 500000000000 / 10;
        let v1 = v0 + monthly_vested(500000000000 - v0, 0x2::clock::timestamp_ms(arg1) - arg0.launch_at_ms, 24);
        let v2 = v1 - arg0.treasury_claimed;
        assert!(v2 > 0, 10);
        arg0.treasury_claimed = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<DSLVR>>(0x2::coin::from_balance<DSLVR>(0x2::balance::split<DSLVR>(&mut arg0.treasury, v2), arg2), arg0.treasury_recipient);
    }

    public fun configure_launch(arg0: &mut LaunchVault, arg1: &AllocationAdminCap, arg2: u64, arg3: address, arg4: address, arg5: address, arg6: &0x2::clock::Clock) {
        assert!(!arg0.configured, 8);
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg6), 12);
        assert!(arg3 != @0x0, 13);
        assert!(arg4 != @0x0, 13);
        assert!(arg5 != @0x0, 13);
        arg0.configured = true;
        arg0.launch_at_ms = arg2;
        arg0.treasury_recipient = arg3;
        arg0.team_recipient = arg4;
        arg0.staking_recipient = arg5;
    }

    public fun forfeited(arg0: &Refinery) : u64 {
        arg0.forfeited
    }

    fun init(arg0: DSLVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSLVR>(arg0, 6, b"DSLVR", b"Digital SLVR", b"Digital store of value mined through SLVRBLOX on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.slvrblox.com/brand/dslvr-coin.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSLVR>>(v1);
        let v3 = 0x2::coin::into_balance<DSLVR>(0x2::coin::mint<DSLVR>(&mut v2, 2000000000000, arg1));
        assert!(0x2::balance::value<DSLVR>(&v3) == 500000000000, 3);
        let v4 = LaunchVault{
            id                  : 0x2::object::new(arg1),
            configured          : false,
            launch_at_ms        : 0,
            treasury_recipient  : @0x0,
            team_recipient      : @0x0,
            staking_recipient   : @0x0,
            liquidity           : 0x2::balance::split<DSLVR>(&mut v3, 750000000000),
            treasury            : v3,
            staking             : 0x2::balance::split<DSLVR>(&mut v3, 350000000000),
            team                : 0x2::balance::split<DSLVR>(&mut v3, 250000000000),
            presale             : 0x2::balance::split<DSLVR>(&mut v3, 150000000000),
            liquidity_withdrawn : false,
            presale_withdrawn   : false,
            treasury_claimed    : 0,
            staking_claimed     : 0,
            team_claimed        : 0,
        };
        0x2::transfer::share_object<LaunchVault>(v4);
        let v5 = AllocationAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AllocationAdminCap>(v5, 0x2::tx_context::sender(arg1));
        let v6 = RewardCap{id: 0x2::object::new(arg1)};
        let v7 = Refinery{
            id            : 0x2::object::new(arg1),
            treasury      : v2,
            reward_cap_id : 0x2::object::id<RewardCap>(&v6),
            awarded       : 0,
            minted        : 0,
            forfeited     : 0,
            positions     : 0x1::vector::empty<UnrefinedPosition>(),
        };
        0x2::transfer::share_object<Refinery>(v7);
        0x2::transfer::transfer<RewardCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun launch_allocation() : u64 {
        2000000000000
    }

    public fun max_supply() : u64 {
        5000000000000
    }

    public fun minted(arg0: &Refinery) : u64 {
        arg0.minted
    }

    fun monthly_vested(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1 / 2592000000;
        if (v0 >= arg2) {
            arg0
        } else {
            mul_div(arg0, v0, arg2)
        }
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun player_reward_allocation() : u64 {
        3000000000000
    }

    public fun position_count(arg0: &Refinery) : u64 {
        0x1::vector::length<UnrefinedPosition>(&arg0.positions)
    }

    public fun refining_period_ms() : u64 {
        86400000
    }

    public fun release_liquidity(arg0: &mut LaunchVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_launched(arg0, arg1);
        assert!(!arg0.liquidity_withdrawn, 11);
        arg0.liquidity_withdrawn = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<DSLVR>>(0x2::coin::from_balance<DSLVR>(0x2::balance::withdraw_all<DSLVR>(&mut arg0.liquidity), arg2), arg0.treasury_recipient);
    }

    public fun remaining_award_capacity(arg0: &Refinery) : u64 {
        3000000000000 - arg0.awarded
    }

    public fun take_presale_inventory(arg0: &mut LaunchVault, arg1: &AllocationAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DSLVR> {
        assert!(arg0.configured, 7);
        assert!(!arg0.presale_withdrawn, 11);
        arg0.presale_withdrawn = true;
        0x2::coin::from_balance<DSLVR>(0x2::balance::withdraw_all<DSLVR>(&mut arg0.presale), arg2)
    }

    // decompiled from Move bytecode v7
}

