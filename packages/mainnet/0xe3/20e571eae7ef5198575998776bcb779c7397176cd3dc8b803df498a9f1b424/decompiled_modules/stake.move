module 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::stake {
    struct StakeConfig has key {
        id: 0x2::object::UID,
        total_staked: u64,
        total_reward: u64,
        extra_data: vector<u64>,
        extra_nested_data: vector<vector<u64>>,
        active: bool,
        min_reward_percentage: u64,
        max_reward_percentage: u64,
        mid_reward_percentage: u64,
        min_days: u64,
        max_days: u64,
        mid_days: u64,
    }

    struct SITYStaked has copy, drop {
        wallet_id: 0x2::object::ID,
        amount: u64,
        staker: address,
        withdraw_time: u64,
        duration: u64,
        reward: u64,
    }

    struct SITYUnstaked has copy, drop {
        wallet_id: 0x2::object::ID,
        amount: u64,
        unstaker: address,
    }

    struct StakeCalculated has copy, drop {
        wallet_id: 0x2::object::ID,
        amount: u64,
        reward: u64,
        population_reward: u64,
        base_reward: u64,
        base_percentage: u64,
        population_percentage: u64,
        total_percentage: u64,
    }

    public entry fun stake(arg0: &mut 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::GameData, arg1: &mut 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::City, arg2: &mut 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::Wallet, arg3: &mut StakeConfig, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::get_available_balance(arg2) >= arg4, 0);
        assert!(arg5 > 0, 1);
        assert!(0x2::tx_context::sender(arg7) == 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::get_wallet_owner(arg2), 2);
        assert!(arg3.active, 3);
        assert!(0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::get_game_version(arg0) == 1, 5);
        let v0 = calculate_stake_reward(arg1, arg2, arg3, arg4, arg5);
        arg3.total_staked = arg3.total_staked + arg4;
        arg3.total_reward = arg3.total_reward + v0;
        let v1 = 0x2::clock::timestamp_ms(arg6) + arg5 * 24 * 60 * 60 * 1000;
        0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::stake_sity(arg0, arg2, arg4, arg5, v1, v0, arg7);
        let v2 = SITYStaked{
            wallet_id     : 0x2::object::id<0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::Wallet>(arg2),
            amount        : arg4,
            staker        : 0x2::tx_context::sender(arg7),
            withdraw_time : v1,
            duration      : arg5,
            reward        : v0,
        };
        0x2::event::emit<SITYStaked>(v2);
    }

    fun calculate_stake_reward(arg0: &mut 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::City, arg1: &0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::Wallet, arg2: &StakeConfig, arg3: u64, arg4: u64) : u64 {
        assert!(arg4 >= arg2.min_days && arg4 <= arg2.max_days, 1);
        let v0 = if (arg4 < arg2.mid_days) {
            arg2.min_reward_percentage + (arg2.mid_reward_percentage - arg2.min_reward_percentage) * (arg4 - arg2.min_days) * 1000 / (arg2.mid_days - arg2.min_days) / 1000
        } else {
            arg2.mid_reward_percentage + (arg2.max_reward_percentage - arg2.mid_reward_percentage) * (arg4 - arg2.mid_days) * 1000 / (arg2.max_days - arg2.mid_days) / 1000
        };
        let v1 = 1000 + 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::get_city_population(arg0, arg1) * 1000 / 500000000;
        let v2 = v0 * v1 / 1000;
        let v3 = arg3 * v2 / 1000;
        let v4 = arg3 * v0 / 1000;
        let v5 = StakeCalculated{
            wallet_id             : 0x2::object::id<0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::Wallet>(arg1),
            amount                : arg3,
            reward                : v3,
            population_reward     : v3 - v4,
            base_reward           : v4,
            base_percentage       : v0,
            population_percentage : v0 * v1 / 1000 - v0,
            total_percentage      : v2,
        };
        0x2::event::emit<StakeCalculated>(v5);
        v3
    }

    public entry fun create_stake_config(arg0: &mut 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::GameData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::get_game_publisher(arg0), 4);
        let v0 = StakeConfig{
            id                    : 0x2::object::new(arg1),
            total_staked          : 0,
            total_reward          : 0,
            extra_data            : vector[],
            extra_nested_data     : vector[],
            active                : true,
            min_reward_percentage : 150,
            max_reward_percentage : 1300,
            mid_reward_percentage : 840,
            min_days              : 7,
            max_days              : 90,
            mid_days              : 45,
        };
        0x2::transfer::share_object<StakeConfig>(v0);
    }

    public entry fun pause_staking(arg0: &mut 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::GameData, arg1: &mut StakeConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::get_game_publisher(arg0), 4);
        arg1.active = false;
    }

    public entry fun resume_staking(arg0: &mut 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::GameData, arg1: &mut StakeConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x5b9b4cd82aee3d5a942eebe9c2da38f411d82bfdfea1204f2486e45b5868b44f::nft::get_game_publisher(arg0), 4);
        arg1.active = true;
    }

    // decompiled from Move bytecode v6
}

