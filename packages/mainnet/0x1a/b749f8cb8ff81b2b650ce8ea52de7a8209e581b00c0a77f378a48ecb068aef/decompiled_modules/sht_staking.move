module 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::sht_staking {
    struct StakePosition has key {
        id: 0x2::object::UID,
        owner: address,
        staked_amount: u64,
        stake_timestamp: u64,
    }

    struct StakingConfig has key {
        id: 0x2::object::UID,
        lock_duration_ms: u64,
        multiplier: u64,
        min_stake: u64,
        total_staked: u64,
        total_positions: u64,
        paused: bool,
    }

    struct SHTStaked has copy, drop {
        player: address,
        amount: u64,
        stake_timestamp: u64,
    }

    struct SHTClaimed has copy, drop {
        player: address,
        original_amount: u64,
        reward_amount: u64,
    }

    struct StakingConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        creator: address,
    }

    struct StakingConfigUpdated has copy, drop {
        field: vector<u8>,
        old_value: u64,
        new_value: u64,
        updated_by: address,
    }

    struct StakingPauseToggled has copy, drop {
        paused: bool,
        updated_by: address,
    }

    public entry fun admin_pause_staking(arg0: &0x2::package::Publisher, arg1: &mut StakingConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<StakingConfig>(arg0), 3);
        arg1.paused = arg2;
        let v0 = StakingPauseToggled{
            paused     : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<StakingPauseToggled>(v0);
    }

    public entry fun admin_update_lock_duration(arg0: &0x2::package::Publisher, arg1: &mut StakingConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<StakingConfig>(arg0), 3);
        assert!(arg2 >= 2628000000 && arg2 <= 63072000000, 6);
        arg1.lock_duration_ms = arg2;
        let v0 = StakingConfigUpdated{
            field      : b"lock_duration_ms",
            old_value  : arg1.lock_duration_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<StakingConfigUpdated>(v0);
    }

    public entry fun admin_update_min_stake(arg0: &0x2::package::Publisher, arg1: &mut StakingConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<StakingConfig>(arg0), 3);
        arg1.min_stake = arg2;
        let v0 = StakingConfigUpdated{
            field      : b"min_stake",
            old_value  : arg1.min_stake,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<StakingConfigUpdated>(v0);
    }

    public entry fun admin_update_multiplier(arg0: &0x2::package::Publisher, arg1: &mut StakingConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<StakingConfig>(arg0), 3);
        assert!(arg2 >= 1 && arg2 <= 100, 7);
        arg1.multiplier = arg2;
        let v0 = StakingConfigUpdated{
            field      : b"multiplier",
            old_value  : arg1.multiplier,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<StakingConfigUpdated>(v0);
    }

    entry fun claim_stake(arg0: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::config::GlobalConfig, arg1: &mut StakingConfig, arg2: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::StakingMintCap, arg3: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SharedTreasury, arg4: StakePosition, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::config::assert_version_and_feature(arg0, 11, 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::config::feature_sht_staking());
        assert!(0x2::clock::timestamp_ms(arg5) >= arg4.stake_timestamp + arg1.lock_duration_ms, 1);
        let v0 = arg4.staked_amount * arg1.multiplier;
        let v1 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>>(0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::mint_for_staking(arg2, arg3, v0, arg6), v1);
        let v2 = SHTClaimed{
            player          : v1,
            original_amount : arg4.staked_amount,
            reward_amount   : v0,
        };
        0x2::event::emit<SHTClaimed>(v2);
        arg1.total_staked = arg1.total_staked - arg4.staked_amount;
        arg1.total_positions = arg1.total_positions - 1;
        let StakePosition {
            id              : v3,
            owner           : _,
            staked_amount   : _,
            stake_timestamp : _,
        } = arg4;
        0x2::object::delete(v3);
    }

    public entry fun create_staking_config(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<StakingConfig>(arg0), 3);
        let v0 = StakingConfig{
            id               : 0x2::object::new(arg1),
            lock_duration_ms : 15768000000,
            multiplier       : 15,
            min_stake        : 1000000000000,
            total_staked     : 0,
            total_positions  : 0,
            paused           : false,
        };
        let v1 = StakingConfigCreated{
            config_id : 0x2::object::id<StakingConfig>(&v0),
            creator   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<StakingConfigCreated>(v1);
        0x2::transfer::share_object<StakingConfig>(v0);
    }

    public fun get_position_info(arg0: &StakePosition) : (address, u64, u64) {
        (arg0.owner, arg0.staked_amount, arg0.stake_timestamp)
    }

    public fun get_staking_config_info(arg0: &StakingConfig) : (u64, u64, u64, u64, u64, bool) {
        (arg0.lock_duration_ms, arg0.multiplier, arg0.min_stake, arg0.total_staked, arg0.total_positions, arg0.paused)
    }

    public fun is_position_claimable(arg0: &StakePosition, arg1: &StakingConfig, arg2: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg2) >= arg0.stake_timestamp + arg1.lock_duration_ms
    }

    entry fun stake_sht(arg0: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::config::GlobalConfig, arg1: &mut StakingConfig, arg2: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::StakingMintCap, arg3: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SharedTreasury, arg4: 0x2::coin::Coin<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::config::assert_version_and_feature(arg0, 11, 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::config::feature_sht_staking());
        assert!(!arg1.paused, 5);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>(&arg4);
        assert!(v1 >= arg1.min_stake, 4);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::burn(arg3, arg4);
        let v3 = StakePosition{
            id              : 0x2::object::new(arg6),
            owner           : v0,
            staked_amount   : v1,
            stake_timestamp : v2,
        };
        arg1.total_staked = arg1.total_staked + v1;
        arg1.total_positions = arg1.total_positions + 1;
        let v4 = SHTStaked{
            player          : v0,
            amount          : v1,
            stake_timestamp : v2,
        };
        0x2::event::emit<SHTStaked>(v4);
        0x2::transfer::transfer<StakePosition>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

