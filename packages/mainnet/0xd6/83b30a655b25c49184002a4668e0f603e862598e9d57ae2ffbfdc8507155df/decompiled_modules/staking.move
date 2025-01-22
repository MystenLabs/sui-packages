module 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::staking {
    struct RewardInfo has copy, drop, store {
        reward_coin_type: 0x1::type_name::TypeName,
        acc_reward_per_share: u64,
        last_reward_time: u64,
    }

    struct RewardManager has store, key {
        id: 0x2::object::UID,
        total_staked_amount: u64,
        rewards_infos: 0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardInfo>,
        user_positions_record: 0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, bool>>,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        staked_amount: u64,
        reward_debt: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        waiting_claim_reward: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    public fun add_suspicious_position(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::AdminCap, arg1: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg2: &mut RewardManager, arg3: address) {
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::add_suspicious_position(arg0, arg1, arg3);
        arg2.total_staked_amount = arg2.total_staked_amount - 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::get_position_staked_amount(arg1, arg3);
    }

    public fun get_position_staked_amount(arg0: &StakePosition) : u64 {
        arg0.staked_amount
    }

    public fun remove_suspicious_position(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::AdminCap, arg1: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg2: &mut RewardManager, arg3: address) {
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::remove_suspicious_position(arg0, arg1, arg3);
        arg2.total_staked_amount = arg2.total_staked_amount + 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::get_position_staked_amount(arg1, arg3);
    }

    fun add_position_pending_reward(arg0: &mut StakePosition, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.waiting_claim_reward, arg1)) {
            let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.waiting_claim_reward, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.waiting_claim_reward, arg1, arg2);
        };
    }

    fun add_user_position_record(arg0: &mut 0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, bool>>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(arg0, v0)) {
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, bool>>(arg0, v0, 0x2::table::new<0x2::object::ID, bool>(arg2));
        };
        0x2::table::add<0x2::object::ID, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(arg0, v0), arg1, true);
    }

    fun all_reward_types(arg0: &RewardManager) : vector<0x1::type_name::TypeName> {
        0x2::vec_map::keys<0x1::type_name::TypeName, RewardInfo>(&arg0.rewards_infos)
    }

    fun assert_not_enough_balance(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::errors::error_not_enough_balance());
    }

    fun assert_user_position_exist(arg0: &RewardManager, arg1: address) {
        assert!(check_user_position_not_exist(arg0, arg1), 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::errors::error_user_position_already_exists());
    }

    public fun calculate_all_pending_rewards(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &RewardManager, arg2: &StakePosition, arg3: &0x2::clock::Clock) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0x1::vector::empty<u64>();
        while (v0 < 0x2::vec_map::size<0x1::type_name::TypeName, RewardInfo>(&arg1.rewards_infos)) {
            let (v3, _) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, RewardInfo>(&arg1.rewards_infos, v0);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, *v3);
            0x1::vector::push_back<u64>(&mut v2, pre_calculate_pending_reward(arg0, arg1, arg2, *v3, arg3));
            v0 = v0 + 1;
        };
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::events::emit_calculate_all_pending_reward(v2, v1);
    }

    fun calculate_new_reward_per_share(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 == 0) {
            return 0
        };
        assert!(arg2 >= arg1, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::errors::error_invalid_time());
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_div_u64(0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_u64(arg0, arg2 - arg1), 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::one(), arg3)
    }

    public fun calculate_pending_reward<T0>(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &RewardManager, arg2: &StakePosition, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::events::emit_calculate_pending_reward(pre_calculate_pending_reward(arg0, arg1, arg2, v0, arg3), v0);
    }

    fun check_user_position_not_exist(arg0: &RewardManager, arg1: address) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.user_positions_record, arg1)) {
            return true
        };
        0x2::table::is_empty<0x2::object::ID, bool>(0x2::table::borrow<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.user_positions_record, arg1))
    }

    public fun claim_reward<T0>(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::Vault, arg2: &mut RewardManager, arg3: &mut StakePosition, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<StakePosition>(arg3);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::assert_suspicious_position(arg0, 0x2::object::id_to_address(&v0));
        let v1 = 0x1::type_name::get<T0>();
        update_reward_info_status(arg0, arg2, v1, arg4);
        let v2 = update_position_when_claim(arg2, arg3, v1);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::events::emit_claim_reward(v2, v1, 0x2::tx_context::sender(arg5));
        0x2::coin::from_balance<T0>(0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::withdraw_reward<T0>(arg1, v2), arg5)
    }

    fun clear_position_waiting_claim_reward(arg0: &mut StakePosition, arg1: 0x1::type_name::TypeName) {
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.waiting_claim_reward, arg1);
    }

    public fun close_stake_position(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut RewardManager, arg2: StakePosition, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<StakePosition>(&arg2);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::assert_suspicious_position(arg0, 0x2::object::id_to_address(&v0));
        assert!(arg2.staked_amount == 0, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::errors::error_stake_position_staked_amount_not_zero());
        assert!(0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg1.user_positions_record, 0x2::tx_context::sender(arg3)), 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::errors::error_user_position_not_exist());
        assert!(0x2::table::is_empty<0x1::type_name::TypeName, u64>(&arg2.waiting_claim_reward), 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::errors::error_waiting_claim_reward_not_empty());
        let v1 = 0x2::object::id<StakePosition>(&arg2);
        let v2 = &mut arg1.user_positions_record;
        remove_user_position_record(v2, v1, arg3);
        destroy(arg2);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::events::emit_close_stake_position(v1, 0x2::tx_context::sender(arg3));
    }

    public fun create_stake_position(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut RewardManager, arg2: &mut 0x2::tx_context::TxContext) : StakePosition {
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::assert_current_version_invalid(arg0);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::assert_allow_staking(arg0);
        assert_user_position_exist(arg1, 0x2::tx_context::sender(arg2));
        let v0 = StakePosition{
            id                   : 0x2::object::new(arg2),
            staked_amount        : 0,
            reward_debt          : 0x2::table::new<0x1::type_name::TypeName, u64>(arg2),
            waiting_claim_reward : 0x2::table::new<0x1::type_name::TypeName, u64>(arg2),
        };
        let v1 = 0x2::object::id<StakePosition>(&v0);
        let v2 = &mut arg1.user_positions_record;
        add_user_position_record(v2, v1, arg2);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::events::emit_create_stake_position(v1, 0x2::tx_context::sender(arg2));
        v0
    }

    public fun create_stake_position_and_stake(arg0: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut RewardManager, arg2: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::Vault, arg3: 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : StakePosition {
        let v0 = create_stake_position(arg0, arg1, arg5);
        let v1 = &mut v0;
        stake(arg0, arg2, arg1, v1, arg3, arg4, arg5);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::events::emit_create_stake_position(0x2::object::id<StakePosition>(&v0), 0x2::tx_context::sender(arg5));
        v0
    }

    fun destroy(arg0: StakePosition) {
        let StakePosition {
            id                   : v0,
            staked_amount        : _,
            reward_debt          : v2,
            waiting_claim_reward : v3,
        } = arg0;
        0x2::table::destroy_empty<0x1::type_name::TypeName, u64>(v3);
        0x2::table::drop<0x1::type_name::TypeName, u64>(v2);
        0x2::object::delete(v0);
    }

    public fun entry_claim_reward<T0>(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::Vault, arg2: &mut RewardManager, arg3: &mut StakePosition, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_reward<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun entry_create_stake_position(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut RewardManager, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_stake_position(arg0, arg1, arg2);
        0x2::transfer::transfer<StakePosition>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun entry_create_stake_position_and_stake(arg0: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut RewardManager, arg2: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::Vault, arg3: 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = create_stake_position_and_stake(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<StakePosition>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun entry_stake(arg0: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::Vault, arg2: &mut RewardManager, arg3: &mut StakePosition, arg4: 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        stake(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun entry_unstake(arg0: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::Vault, arg2: &mut RewardManager, arg3: &mut StakePosition, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = unstake(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun get_position_reward_debt(arg0: &StakePosition, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.reward_debt, arg1)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_debt, arg1)
        } else {
            0
        }
    }

    public fun get_position_waiting_claim_reward(arg0: &StakePosition, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.waiting_claim_reward, arg1)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.waiting_claim_reward, arg1)
        } else {
            0
        }
    }

    public fun get_reward_total_staked_amount(arg0: &RewardManager) : u64 {
        arg0.total_staked_amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardManager{
            id                    : 0x2::object::new(arg0),
            total_staked_amount   : 0,
            rewards_infos         : 0x2::vec_map::empty<0x1::type_name::TypeName, RewardInfo>(),
            user_positions_record : 0x2::table::new<address, 0x2::table::Table<0x2::object::ID, bool>>(arg0),
        };
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::events::emit_init_reward_manager(0x2::object::id<RewardManager>(&v0));
        0x2::transfer::public_share_object<RewardManager>(v0);
    }

    fun init_reward_info(arg0: &mut RewardManager, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, RewardInfo>(&arg0.rewards_infos, &arg1)) {
            let v0 = RewardInfo{
                reward_coin_type     : arg1,
                acc_reward_per_share : 0,
                last_reward_time     : 0x2::clock::timestamp_ms(arg2) / 1000,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, RewardInfo>(&mut arg0.rewards_infos, arg1, v0);
        };
    }

    public fun pre_calculate_pending_reward(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &RewardManager, arg2: &StakePosition, arg3: 0x1::type_name::TypeName, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardInfo>(&arg1.rewards_infos, &arg3);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_div_u64(arg2.staked_amount, v0.acc_reward_per_share + calculate_new_reward_per_share(0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::get_config_emission_rate(arg0, &arg3), v0.last_reward_time, 0x2::clock::timestamp_ms(arg4) / 1000, arg1.total_staked_amount), 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::one()) - get_position_reward_debt(arg2, arg3) + get_position_waiting_claim_reward(arg2, arg3)
    }

    public fun register_reward<T0>(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::AdminCap, arg1: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg2: &mut RewardManager, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::set_reward_config<T0>(arg0, arg1, arg3, arg4, arg5, arg7);
        init_reward_info(arg2, 0x1::type_name::get<T0>(), arg6);
    }

    fun remove_user_position_record(arg0: &mut 0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, bool>>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(arg0, v0);
        0x2::table::remove<0x2::object::ID, bool>(v1, arg1);
        if (0x2::table::is_empty<0x2::object::ID, bool>(v1)) {
            0x2::table::destroy_empty<0x2::object::ID, bool>(0x2::table::remove<address, 0x2::table::Table<0x2::object::ID, bool>>(arg0, v0));
        };
    }

    fun reward_info_size(arg0: &RewardManager) : u64 {
        0x2::vec_map::size<0x1::type_name::TypeName, RewardInfo>(&arg0.rewards_infos)
    }

    public fun stake(arg0: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::Vault, arg2: &mut RewardManager, arg3: &mut StakePosition, arg4: 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::assert_current_version_invalid(arg0);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::assert_allow_staking(arg0);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::assert_max_staked_amount(arg0, 0x2::coin::value<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(&arg4));
        let v0 = 0x2::object::id<StakePosition>(arg3);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::record_position_staked_amount(arg0, 0x2::object::id_to_address(&v0), 0x2::coin::value<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(&arg4));
        let v1 = 0x2::coin::value<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(&arg4);
        let v2 = all_reward_types(arg2);
        let v3 = 0;
        while (v3 < reward_info_size(arg2)) {
            let v4 = 0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            update_reward_info_status(arg0, arg2, *v4, arg5);
            update_position_when_stake(arg2, arg3, v4, v1);
            v3 = v3 + 1;
        };
        arg3.staked_amount = arg3.staked_amount + v1;
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::deposit_staked(arg1, 0x2::coin::into_balance<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(arg4));
        let v5 = 0x2::object::id<StakePosition>(arg3);
        if (!0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::check_is_suspicious_position(arg0, 0x2::object::id_to_address(&v5))) {
            arg2.total_staked_amount = arg2.total_staked_amount + v1;
        };
        let v6 = 0x2::object::id<StakePosition>(arg3);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::record_position_staked_amount(arg0, 0x2::object::id_to_address(&v6), arg3.staked_amount);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::events::emit_stake(v1, 0x1::type_name::get<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(), arg3.staked_amount, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::get_vault_staked_balance(arg1), 0x2::tx_context::sender(arg6));
    }

    public fun unstake(arg0: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::Vault, arg2: &mut RewardManager, arg3: &mut StakePosition, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB> {
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::assert_current_version_invalid(arg0);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::assert_allow_staking(arg0);
        let v0 = 0x2::object::id<StakePosition>(arg3);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::assert_suspicious_position(arg0, 0x2::object::id_to_address(&v0));
        assert_not_enough_balance(arg4, arg3.staked_amount);
        let v1 = all_reward_types(arg2);
        let v2 = 0;
        while (v2 < reward_info_size(arg2)) {
            let v3 = 0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            update_reward_info_status(arg0, arg2, *v3, arg5);
            update_position_when_unstake(arg2, arg3, v3, arg4);
            v2 = v2 + 1;
        };
        arg3.staked_amount = arg3.staked_amount - arg4;
        let v4 = 0x2::object::id<StakePosition>(arg3);
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::record_position_staked_amount(arg0, 0x2::object::id_to_address(&v4), arg3.staked_amount);
        arg2.total_staked_amount = arg2.total_staked_amount - arg4;
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::events::emit_unstake(arg4, arg3.staked_amount, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::get_vault_staked_balance(arg1), 0x1::type_name::get<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(), 0x2::tx_context::sender(arg6));
        0x2::coin::from_balance<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::vault::withdraw_staked(arg1, arg4), arg6)
    }

    fun update_position_when_claim(arg0: &RewardManager, arg1: &mut StakePosition, arg2: 0x1::type_name::TypeName) : u64 {
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardInfo>(&arg0.rewards_infos, &arg2);
        let v1 = 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_div_u64(arg1.staked_amount, v0.acc_reward_per_share, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::one()) - get_position_reward_debt(arg1, arg2);
        add_position_pending_reward(arg1, arg2, v1);
        let v2 = get_position_waiting_claim_reward(arg1, arg2);
        clear_position_waiting_claim_reward(arg1, arg2);
        let v3 = 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_div_u64(arg1.staked_amount, v0.acc_reward_per_share, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::one());
        update_reward_debt(arg1, arg2, v3);
        v2
    }

    fun update_position_when_stake(arg0: &RewardManager, arg1: &mut StakePosition, arg2: &0x1::type_name::TypeName, arg3: u64) {
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardInfo>(&arg0.rewards_infos, arg2);
        let v1 = 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_div_u64(arg1.staked_amount, v0.acc_reward_per_share, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::one()) - get_position_reward_debt(arg1, *arg2);
        add_position_pending_reward(arg1, *arg2, v1);
        let v2 = 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_div_u64(arg1.staked_amount + arg3, v0.acc_reward_per_share, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::one());
        update_reward_debt(arg1, *arg2, v2);
    }

    fun update_position_when_unstake(arg0: &RewardManager, arg1: &mut StakePosition, arg2: &0x1::type_name::TypeName, arg3: u64) {
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardInfo>(&arg0.rewards_infos, arg2);
        let v1 = 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_div_u64(arg1.staked_amount, v0.acc_reward_per_share, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::one()) - get_position_reward_debt(arg1, *arg2);
        add_position_pending_reward(arg1, *arg2, v1);
        let v2 = 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_div_u64(arg1.staked_amount - arg3, v0.acc_reward_per_share, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::one());
        update_reward_debt(arg1, *arg2, v2);
    }

    public fun update_reward_config<T0>(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::AdminCap, arg1: &mut 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg2: &mut RewardManager, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg2.rewards_infos, &v0);
        let v3 = 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::get_config_reward_end_time(arg1, &v0);
        let v4 = if (v3 < v1) {
            v3 - v2.last_reward_time
        } else {
            v1 - v2.last_reward_time
        };
        if (v4 > 0 && arg2.total_staked_amount > 0) {
            v2.acc_reward_per_share = v2.acc_reward_per_share + 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_div_u64(0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_u64(v4, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::get_config_emission_rate(arg1, &v0)), 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::one(), arg2.total_staked_amount);
        };
        v2.last_reward_time = v1;
        0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::set_reward_config<T0>(arg0, arg1, arg3, arg4, arg5, arg7);
    }

    fun update_reward_debt(arg0: &mut StakePosition, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.reward_debt, arg1)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.reward_debt, arg1) = arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.reward_debt, arg1, arg2);
        };
    }

    fun update_reward_info_status(arg0: &0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::ProtocolConfig, arg1: &mut RewardManager, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg1.rewards_infos, &arg2);
        if (v0 <= v1.last_reward_time || arg1.total_staked_amount == 0) {
            v1.last_reward_time = v0;
            return
        };
        let v2 = 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::get_config_reward_end_time(arg0, &arg2);
        let v3 = if (v2 < v0) {
            if (v2 > v1.last_reward_time) {
                v2 - v1.last_reward_time
            } else {
                0
            }
        } else {
            v0 - v1.last_reward_time
        };
        v1.acc_reward_per_share = v1.acc_reward_per_share + 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_div_u64(0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::check_mul_u64(v3, 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::config::get_config_emission_rate(arg0, &arg2)), 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math::one(), arg1.total_staked_amount);
        v1.last_reward_time = v0;
    }

    // decompiled from Move bytecode v6
}

