module 0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap {
    struct SAP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Protocol has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        treasury_cap: 0x2::coin::TreasuryCap<SAP>,
        referrers: 0x2::table::Table<address, address>,
        qualified_referrers: 0x2::table::Table<address, bool>,
        required_nftree_type: vector<u8>,
        initial_price_mist: u64,
        price_tier_size: u64,
        tier_increase_bps: u64,
        liquidity_bps: u64,
        referral_bps: u64,
        compound_bps_per_day: u64,
        collect_bps_per_day: u64,
        max_accrual_ms: u64,
        min_lock_ms: u64,
        liquidity_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        staked_balance: 0x2::balance::Balance<SAP>,
        reward_vault: 0x2::balance::Balance<SAP>,
        total_effective_stake: u64,
        team_airdrop_cap: u64,
        team_airdropped: u64,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        owner: address,
        deposited: u64,
        effective_stake: u64,
        total_collected: u64,
        last_action_ms: u64,
        locked_until_ms: u64,
    }

    struct Minted has copy, drop {
        buyer: address,
        input_sui: u64,
        minted: u64,
        price_mist: u64,
        referral_paid: u64,
    }

    struct ReferrerBound has copy, drop {
        user: address,
        referrer: address,
    }

    struct ReferrerQualified has copy, drop {
        referrer: address,
        nftree_id: 0x2::object::ID,
        nftree_type: vector<u8>,
    }

    struct RequiredNFTreeTypeUpdated has copy, drop {
        admin: address,
        old_type: vector<u8>,
        new_type: vector<u8>,
    }

    struct Staked has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        locked_until_ms: u64,
    }

    struct Compounded has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        reward: u64,
    }

    struct Collected has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        reward: u64,
    }

    struct Withdrawn has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct RewardsFunded has copy, drop {
        funder: address,
        amount: u64,
    }

    struct TeamAirdropCapUpdated has copy, drop {
        admin: address,
        old_cap: u64,
        new_cap: u64,
    }

    struct TeamAirdropped has copy, drop {
        recipient: address,
        amount: u64,
        total_team_airdropped: u64,
        team_airdrop_cap: u64,
    }

    struct ReserveWithdrawn has copy, drop {
        admin: address,
        recipient: address,
        amount: u64,
        liquidity_reserve: bool,
    }

    struct PauseChanged has copy, drop {
        paused: bool,
    }

    public fun total_supply(arg0: &Protocol) : u64 {
        0x2::coin::total_supply<SAP>(&arg0.treasury_cap)
    }

    fun apply_throttle(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg0 == 0) {
            return 0
        };
        let v0 = (((arg1 as u128) * (10000 as u128) / (arg2 as u128)) as u64);
        let v1 = if (v0 >= 200000) {
            1000
        } else if (v0 >= 175000) {
            2000
        } else if (v0 >= 150000) {
            3000
        } else if (v0 >= 125000) {
            4000
        } else if (v0 >= 100000) {
            5000
        } else if (v0 >= 75000) {
            6000
        } else if (v0 >= 50000) {
            7000
        } else if (v0 >= 25000) {
            8000
        } else if (v0 >= 10000) {
            9000
        } else {
            10000
        };
        bps_amount(arg0, v1)
    }

    fun assert_admin(arg0: &Protocol, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 2);
    }

    fun assert_live(arg0: &Protocol) {
        assert!(!arg0.paused, 1);
    }

    fun assert_nftree_type_limited(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= 160, 16);
    }

    fun assert_position_owner(arg0: &StakePosition, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 8);
    }

    fun assert_qualified_referrer(arg0: &Protocol, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.qualified_referrers, arg1), 17);
    }

    fun assert_reward_available(arg0: &Protocol, arg1: u64) {
        assert!(arg1 > 0, 10);
        assert!(arg1 <= 0x2::balance::value<SAP>(&arg0.reward_vault), 11);
    }

    entry fun bind_referrer(arg0: &mut Protocol, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 != @0x0 && arg1 != v0, 5);
        assert!(!0x2::table::contains<address, address>(&arg0.referrers, v0), 6);
        assert_qualified_referrer(arg0, arg1);
        0x2::table::add<address, address>(&mut arg0.referrers, v0, arg1);
        let v1 = ReferrerBound{
            user     : v0,
            referrer : arg1,
        };
        0x2::event::emit<ReferrerBound>(v1);
    }

    fun bps_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun calculate_reward(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        assert!(arg3 >= arg2, 13);
        let v0 = arg3 - arg2;
        let v1 = v0;
        if (v0 > arg4) {
            v1 = arg4;
        };
        apply_throttle((((arg0 as u128) * (arg1 as u128) * (v1 as u128) / (86400000 as u128) / (10000 as u128)) as u64), arg5, arg6)
    }

    entry fun collect(arg0: &mut Protocol, arg1: &mut StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert_position_owner(arg1, arg3);
        let v0 = pending_collect(arg0, arg1, arg2);
        assert_reward_available(arg0, v0);
        arg1.total_collected = arg1.total_collected + v0;
        arg1.last_action_ms = 0x2::clock::timestamp_ms(arg2);
        let v1 = Collected{
            position_id : 0x2::object::id<StakePosition>(arg1),
            owner       : arg1.owner,
            reward      : v0,
        };
        0x2::event::emit<Collected>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAP>>(0x2::coin::from_balance<SAP>(0x2::balance::split<SAP>(&mut arg0.reward_vault, v0), arg3), arg1.owner);
    }

    entry fun compound(arg0: &mut Protocol, arg1: &mut StakePosition, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert_position_owner(arg1, arg3);
        let v0 = pending_compound(arg0, arg1, arg2);
        assert_reward_available(arg0, v0);
        0x2::balance::join<SAP>(&mut arg0.staked_balance, 0x2::balance::split<SAP>(&mut arg0.reward_vault, v0));
        arg1.effective_stake = arg1.effective_stake + v0;
        arg0.total_effective_stake = arg0.total_effective_stake + v0;
        arg1.last_action_ms = 0x2::clock::timestamp_ms(arg2);
        let v1 = Compounded{
            position_id : 0x2::object::id<StakePosition>(arg1),
            owner       : arg1.owner,
            reward      : v0,
        };
        0x2::event::emit<Compounded>(v1);
    }

    public fun current_price_mist(arg0: &Protocol) : u64 {
        price_for_supply(arg0, total_supply(arg0))
    }

    entry fun fund_rewards(arg0: &mut Protocol, arg1: 0x2::coin::Coin<SAP>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<SAP>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<SAP>(&mut arg0.reward_vault, 0x2::coin::into_balance<SAP>(arg1));
        let v1 = RewardsFunded{
            funder : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<RewardsFunded>(v1);
    }

    fun init(arg0: SAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAP>(arg0, 9, b"SAP", b"SAP", b"The Woods protocol token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAP>>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, v0);
        let v4 = Protocol{
            id                    : 0x2::object::new(arg1),
            admin                 : v0,
            paused                : false,
            treasury_cap          : v1,
            referrers             : 0x2::table::new<address, address>(arg1),
            qualified_referrers   : 0x2::table::new<address, bool>(arg1),
            required_nftree_type  : b"f6c6d439ea0da2f3e9ba79e4992a7a4c113215fbf54c442ac9020c315f953705::collection::NFT",
            initial_price_mist    : 10000000,
            price_tier_size       : 1000000 * 1000000000,
            tier_increase_bps     : 2500,
            liquidity_bps         : 6500,
            referral_bps          : 500,
            compound_bps_per_day  : 200,
            collect_bps_per_day   : 100,
            max_accrual_ms        : 604800000,
            min_lock_ms           : 86400000 * 30,
            liquidity_reserve     : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury_reserve      : 0x2::balance::zero<0x2::sui::SUI>(),
            staked_balance        : 0x2::balance::zero<SAP>(),
            reward_vault          : 0x2::balance::zero<SAP>(),
            total_effective_stake : 0,
            team_airdrop_cap      : 0,
            team_airdropped       : 0,
        };
        0x2::transfer::share_object<Protocol>(v4);
    }

    public fun is_authorized_nftree<T0: key>(arg0: &Protocol) : bool {
        nftree_type<T0>() == arg0.required_nftree_type
    }

    public fun is_qualified_referrer(arg0: &Protocol, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.qualified_referrers, arg1)
    }

    fun mint_amount_for_price(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (1000000000 as u128) / (arg1 as u128)) as u64)
    }

    entry fun mint_and_stake_with_sui(arg0: &mut Protocol, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(arg2 >= arg0.min_lock_ms, 7);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 3);
        let v2 = current_price_mist(arg0);
        let v3 = mint_amount_for_price(v1, v2);
        assert!(v3 > 0, 3);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v5 = &mut v4;
        let v6 = pay_referral_if_qualified(arg0, v0, v1, v5, arg4);
        let v7 = bps_amount(v1, arg0.liquidity_bps);
        if (v7 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.liquidity_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v7));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_reserve, v4);
        0x2::balance::join<SAP>(&mut arg0.staked_balance, 0x2::coin::into_balance<SAP>(0x2::coin::mint<SAP>(&mut arg0.treasury_cap, v3, arg4)));
        arg0.total_effective_stake = arg0.total_effective_stake + v3;
        let v8 = 0x2::clock::timestamp_ms(arg3);
        let v9 = StakePosition{
            id              : 0x2::object::new(arg4),
            owner           : v0,
            deposited       : v3,
            effective_stake : v3,
            total_collected : 0,
            last_action_ms  : v8,
            locked_until_ms : v8 + arg2,
        };
        let v10 = Minted{
            buyer         : v0,
            input_sui     : v1,
            minted        : v3,
            price_mist    : v2,
            referral_paid : v6,
        };
        0x2::event::emit<Minted>(v10);
        let v11 = Staked{
            position_id     : 0x2::object::id<StakePosition>(&v9),
            owner           : v0,
            amount          : v3,
            locked_until_ms : v8 + arg2,
        };
        0x2::event::emit<Staked>(v11);
        0x2::transfer::transfer<StakePosition>(v9, v0);
    }

    entry fun mint_with_sui(arg0: &mut Protocol, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_live(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 3);
        let v2 = current_price_mist(arg0);
        let v3 = mint_amount_for_price(v1, v2);
        assert!(v3 > 0, 3);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v5 = bps_amount(v1, arg0.liquidity_bps);
        if (v5 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.liquidity_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v5));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_reserve, v4);
        let v6 = Minted{
            buyer         : v0,
            input_sui     : v1,
            minted        : v3,
            price_mist    : v2,
            referral_paid : 0,
        };
        0x2::event::emit<Minted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAP>>(0x2::coin::mint<SAP>(&mut arg0.treasury_cap, v3, arg2), v0);
    }

    fun next_team_airdrop_total(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0, 14);
        assert!(arg0 <= arg2, 15);
        assert!(arg1 <= arg2 - arg0, 15);
        arg0 + arg1
    }

    public fun nftree_one_time_fee_mist() : u64 {
        25000000000
    }

    fun nftree_type<T0: key>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()))
    }

    fun pay_referral_if_qualified(arg0: &Protocol, arg1: address, arg2: u64, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::table::contains<address, address>(&arg0.referrers, arg1)) {
            return 0
        };
        let v0 = *0x2::table::borrow<address, address>(&arg0.referrers, arg1);
        if (!0x2::table::contains<address, bool>(&arg0.qualified_referrers, v0)) {
            return 0
        };
        let v1 = bps_amount(arg2, arg0.referral_bps);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg3, v1), arg4), v0);
        };
        v1
    }

    public fun pending_collect(arg0: &Protocol, arg1: &StakePosition, arg2: &0x2::clock::Clock) : u64 {
        calculate_reward(arg1.effective_stake, arg0.collect_bps_per_day, arg1.last_action_ms, 0x2::clock::timestamp_ms(arg2), arg0.max_accrual_ms, arg1.total_collected, arg1.deposited)
    }

    public fun pending_compound(arg0: &Protocol, arg1: &StakePosition, arg2: &0x2::clock::Clock) : u64 {
        calculate_reward(arg1.effective_stake, arg0.compound_bps_per_day, arg1.last_action_ms, 0x2::clock::timestamp_ms(arg2), arg0.max_accrual_ms, arg1.total_collected, arg1.deposited)
    }

    fun price_for_supply(arg0: &Protocol, arg1: u64) : u64 {
        (((arg0.initial_price_mist as u128) * ((10000 as u128) + ((arg1 / arg0.price_tier_size) as u128) * (arg0.tier_increase_bps as u128)) / (10000 as u128)) as u64)
    }

    entry fun qualify_referrer_with_nftree<T0: key>(arg0: &mut Protocol, arg1: &T0, arg2: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(is_authorized_nftree<T0>(arg0), 16);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.qualified_referrers, v0), 18);
        0x2::table::add<address, bool>(&mut arg0.qualified_referrers, v0, true);
        let v1 = ReferrerQualified{
            referrer    : v0,
            nftree_id   : 0x2::object::id<T0>(arg1),
            nftree_type : nftree_type<T0>(),
        };
        0x2::event::emit<ReferrerQualified>(v1);
    }

    public fun quote_mint(arg0: &Protocol, arg1: u64) : u64 {
        mint_amount_for_price(arg1, current_price_mist(arg0))
    }

    public fun required_nftree_type(arg0: &Protocol) : vector<u8> {
        arg0.required_nftree_type
    }

    entry fun set_pause(arg0: &AdminCap, arg1: &mut Protocol, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        arg1.paused = arg2;
        let v0 = PauseChanged{paused: arg2};
        0x2::event::emit<PauseChanged>(v0);
    }

    entry fun stake(arg0: &mut Protocol, arg1: 0x2::coin::Coin<SAP>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(arg2 >= arg0.min_lock_ms, 7);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<SAP>(&arg1);
        assert!(v1 > 0, 7);
        0x2::balance::join<SAP>(&mut arg0.staked_balance, 0x2::coin::into_balance<SAP>(arg1));
        arg0.total_effective_stake = arg0.total_effective_stake + v1;
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = StakePosition{
            id              : 0x2::object::new(arg4),
            owner           : v0,
            deposited       : v1,
            effective_stake : v1,
            total_collected : 0,
            last_action_ms  : v2,
            locked_until_ms : v2 + arg2,
        };
        let v4 = Staked{
            position_id     : 0x2::object::id<StakePosition>(&v3),
            owner           : v0,
            amount          : v1,
            locked_until_ms : v2 + arg2,
        };
        0x2::event::emit<Staked>(v4);
        0x2::transfer::transfer<StakePosition>(v3, v0);
    }

    public fun team_airdrop_cap(arg0: &Protocol) : u64 {
        arg0.team_airdrop_cap
    }

    public fun team_airdrop_remaining(arg0: &Protocol) : u64 {
        arg0.team_airdrop_cap - arg0.team_airdropped
    }

    entry fun team_airdrop_sap(arg0: &AdminCap, arg1: &mut Protocol, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        assert_admin(arg1, arg4);
        assert!(arg2 != @0x0, 14);
        let v0 = next_team_airdrop_total(arg1.team_airdropped, arg3, arg1.team_airdrop_cap);
        arg1.team_airdropped = v0;
        let v1 = TeamAirdropped{
            recipient             : arg2,
            amount                : arg3,
            total_team_airdropped : v0,
            team_airdrop_cap      : arg1.team_airdrop_cap,
        };
        0x2::event::emit<TeamAirdropped>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAP>>(0x2::coin::mint<SAP>(&mut arg1.treasury_cap, arg3, arg4), arg2);
    }

    entry fun team_airdrop_to_rewards(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        assert_admin(arg1, arg3);
        let v0 = next_team_airdrop_total(arg1.team_airdropped, arg2, arg1.team_airdrop_cap);
        arg1.team_airdropped = v0;
        0x2::balance::join<SAP>(&mut arg1.reward_vault, 0x2::coin::into_balance<SAP>(0x2::coin::mint<SAP>(&mut arg1.treasury_cap, arg2, arg3)));
        let v1 = TeamAirdropped{
            recipient             : @0x0,
            amount                : arg2,
            total_team_airdropped : v0,
            team_airdrop_cap      : arg1.team_airdrop_cap,
        };
        0x2::event::emit<TeamAirdropped>(v1);
    }

    public fun team_airdropped(arg0: &Protocol) : u64 {
        arg0.team_airdropped
    }

    entry fun update_mint_settings(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg7);
        assert!(arg2 > 0, 4);
        assert!(arg3 > 0, 4);
        assert!(arg4 <= 2500, 4);
        assert!(arg5 <= 7500, 4);
        assert!(arg6 <= 500, 4);
        assert!(arg5 + arg6 <= 10000, 4);
        arg1.initial_price_mist = arg2;
        arg1.price_tier_size = arg3;
        arg1.tier_increase_bps = arg4;
        arg1.liquidity_bps = arg5;
        arg1.referral_bps = arg6;
    }

    entry fun update_required_nftree_type(arg0: &AdminCap, arg1: &mut Protocol, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        assert_nftree_type_limited(&arg2);
        arg1.required_nftree_type = arg2;
        let v0 = RequiredNFTreeTypeUpdated{
            admin    : 0x2::tx_context::sender(arg3),
            old_type : arg1.required_nftree_type,
            new_type : arg1.required_nftree_type,
        };
        0x2::event::emit<RequiredNFTreeTypeUpdated>(v0);
    }

    entry fun update_stake_settings(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg6);
        assert!(arg2 <= 200, 4);
        assert!(arg3 <= 200, 4);
        assert!(arg4 > 0 && arg4 <= 604800000, 4);
        arg1.compound_bps_per_day = arg2;
        arg1.collect_bps_per_day = arg3;
        arg1.max_accrual_ms = arg4;
        arg1.min_lock_ms = arg5;
    }

    entry fun update_team_airdrop_cap(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        assert!(arg2 >= arg1.team_airdropped, 4);
        assert!(arg2 <= 50000000000000000, 4);
        arg1.team_airdrop_cap = arg2;
        let v0 = TeamAirdropCapUpdated{
            admin   : 0x2::tx_context::sender(arg3),
            old_cap : arg1.team_airdrop_cap,
            new_cap : arg2,
        };
        0x2::event::emit<TeamAirdropCapUpdated>(v0);
    }

    entry fun withdraw_liquidity_sui(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg4);
        let v0 = &mut arg1.liquidity_reserve;
        withdraw_sui_reserve(v0, arg2, arg3, true, arg4);
    }

    entry fun withdraw_stake(arg0: &mut Protocol, arg1: StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_live(arg0);
        let StakePosition {
            id              : v0,
            owner           : v1,
            deposited       : _,
            effective_stake : v3,
            total_collected : _,
            last_action_ms  : _,
            locked_until_ms : v6,
        } = arg1;
        let v7 = v0;
        assert!(v1 == 0x2::tx_context::sender(arg3), 8);
        assert!(0x2::clock::timestamp_ms(arg2) >= v6, 9);
        assert!(v3 > 0, 7);
        0x2::object::delete(v7);
        arg0.total_effective_stake = arg0.total_effective_stake - v3;
        let v8 = Withdrawn{
            position_id : 0x2::object::uid_to_inner(&v7),
            owner       : v1,
            amount      : v3,
        };
        0x2::event::emit<Withdrawn>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAP>>(0x2::coin::from_balance<SAP>(0x2::balance::split<SAP>(&mut arg0.staked_balance, v3), arg3), v1);
    }

    fun withdraw_sui_reserve(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<0x2::sui::SUI>(arg0), 12);
        let v0 = ReserveWithdrawn{
            admin             : 0x2::tx_context::sender(arg4),
            recipient         : arg2,
            amount            : arg1,
            liquidity_reserve : arg3,
        };
        0x2::event::emit<ReserveWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, arg1), arg4), arg2);
    }

    entry fun withdraw_treasury_sui(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg4);
        let v0 = &mut arg1.treasury_reserve;
        withdraw_sui_reserve(v0, arg2, arg3, false, arg4);
    }

    // decompiled from Move bytecode v7
}

