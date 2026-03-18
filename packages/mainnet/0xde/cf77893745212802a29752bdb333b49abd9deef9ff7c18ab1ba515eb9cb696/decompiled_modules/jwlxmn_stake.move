module 0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn_stake {
    struct SetUserJwlxmnStakeDataEvent has copy, drop {
        user_mvx_address: 0x1::string::String,
        stake_amount: u64,
    }

    struct ConvertJwlxmnEvent has copy, drop {
        user_address: address,
        user_mvx_address: 0x1::string::String,
        unstake_amount: u64,
    }

    struct MintJwlxmnEvent has copy, drop {
        user_address: address,
        unstake_amount: u64,
    }

    struct EpochRewardsAddedEvent has copy, drop {
        epoch: u64,
        rewards: u64,
    }

    struct RewardsDistributedEvent has copy, drop {
        epoch: u64,
        total_rewards: u64,
        total_stakers: u64,
    }

    struct StakeJwlxmnEvent has copy, drop {
        user: address,
        amount: u64,
        staked_at: u64,
        current_timestamp: u64,
    }

    struct UnstakeJwlxmnEvent has copy, drop {
        user: address,
        amount: u64,
        unstaked_at: u64,
        current_timestamp: u64,
    }

    struct ClaimedRewardsEvent has copy, drop {
        user: address,
        epoch: u64,
        rewards: u64,
        current_timestamp: u64,
    }

    struct UserJwltokenInfo has copy, drop, store {
        jwltoken_staked: u64,
        total_rewards: u64,
        last_staked_at: u64,
        last_epoch_checked: u64,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        is_active: bool,
        total_jwlxmn_converted_amount: u64,
        epoch_period_ms: u64,
        locking_period_ms: u64,
        current_epoch: u64,
        epoch_rewards: u64,
        epoch_start_time: u64,
        last_epoch_got_rewards: u64,
        total_reward_amount: u64,
        reward_amount: u64,
        total_jwlxmn_staked: u64,
        total_jwlxmn_compounded: u64,
        total_stakers: u64,
        total_stakers_checked: u64,
        jwlxmn_vault: 0x2::balance::Balance<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN>,
        user_jwltoken_info: 0x2::linked_table::LinkedTable<address, UserJwltokenInfo>,
        user_stake_amount: 0x2::table::Table<0x1::string::String, u64>,
    }

    public fun add_reward(arg0: &0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::ownership::OperatorCap, arg1: &mut GlobalConfig, arg2: &mut 0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JwlXmnMetadata<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg1.total_stakers > 0, 105);
        arg1.total_reward_amount = arg1.total_reward_amount + arg3;
        arg1.reward_amount = arg1.reward_amount + arg3;
        0x2::coin::put<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN>(&mut arg1.jwlxmn_vault, 0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::mint(arg2, arg3, arg4));
        let v0 = EpochRewardsAddedEvent{
            epoch   : arg1.current_epoch,
            rewards : arg3,
        };
        0x2::event::emit<EpochRewardsAddedEvent>(v0);
        let v1 = 0x2::linked_table::length<address, UserJwltokenInfo>(&arg1.user_jwltoken_info);
        let v2 = 0;
        let v3 = *0x1::option::borrow<address>(0x2::linked_table::front<address, UserJwltokenInfo>(&arg1.user_jwltoken_info));
        while (v2 < v1) {
            let v4 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg1.user_jwltoken_info, v3);
            if (v4.jwltoken_staked > 0) {
                v4.total_rewards = v4.total_rewards + 0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::math::mul_div(v4.jwltoken_staked, arg3, arg1.total_jwlxmn_staked);
            };
            if (v1 >= 2 && v2 < v1 - 1) {
                let v5 = 0x1::option::borrow<address>(0x2::linked_table::next<address, UserJwltokenInfo>(&arg1.user_jwltoken_info, v3));
                v3 = *v5;
            };
            v2 = v2 + 1;
        };
        let v6 = RewardsDistributedEvent{
            epoch         : arg1.current_epoch,
            total_rewards : arg3,
            total_stakers : arg1.total_stakers,
        };
        0x2::event::emit<RewardsDistributedEvent>(v6);
    }

    fun assert_active(arg0: &GlobalConfig) {
        assert!(arg0.is_active, 100);
    }

    fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 1, 1);
    }

    fun check_user_jwltoken_info(arg0: &mut 0x2::linked_table::LinkedTable<address, UserJwltokenInfo>, arg1: address) {
        if (!0x2::linked_table::contains<address, UserJwltokenInfo>(arg0, arg1)) {
            let v0 = UserJwltokenInfo{
                jwltoken_staked    : 0,
                total_rewards      : 0,
                last_staked_at     : 0,
                last_epoch_checked : 0,
            };
            0x2::linked_table::push_back<address, UserJwltokenInfo>(arg0, arg1, v0);
        };
    }

    public fun claim_rewards(arg0: &mut GlobalConfig, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN> {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg0.user_jwltoken_info, 0x2::tx_context::sender(arg3));
        assert!(v0.total_rewards >= arg2, 110);
        v0.total_rewards = v0.total_rewards - arg2;
        arg0.reward_amount = arg0.reward_amount - arg2;
        let v1 = ClaimedRewardsEvent{
            user              : 0x2::tx_context::sender(arg3),
            epoch             : arg0.current_epoch,
            rewards           : arg2,
            current_timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ClaimedRewardsEvent>(v1);
        0x2::coin::take<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN>(&mut arg0.jwlxmn_vault, arg2, arg3)
    }

    public fun convert(arg0: &mut GlobalConfig, arg1: &mut 0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JwlXmnMetadata<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN> {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = 0x2::table::borrow<0x1::string::String, u64>(&arg0.user_stake_amount, arg3);
        assert!(*v0 >= arg2, 101);
        *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.user_stake_amount, arg3) = *v0 - arg2;
        arg0.total_jwlxmn_converted_amount = arg0.total_jwlxmn_converted_amount + arg2;
        let v1 = MintJwlxmnEvent{
            user_address   : 0x2::tx_context::sender(arg4),
            unstake_amount : arg2,
        };
        0x2::event::emit<MintJwlxmnEvent>(v1);
        let v2 = ConvertJwlxmnEvent{
            user_address     : 0x2::tx_context::sender(arg4),
            user_mvx_address : arg3,
            unstake_amount   : arg2,
        };
        0x2::event::emit<ConvertJwlxmnEvent>(v2);
        0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::mint(arg1, arg2, arg4)
    }

    public fun get_user_jwlxmn_info(arg0: &GlobalConfig, arg1: address) : UserJwltokenInfo {
        if (!0x2::linked_table::contains<address, UserJwltokenInfo>(&arg0.user_jwltoken_info, arg1)) {
            UserJwltokenInfo{jwltoken_staked: 0, total_rewards: 0, last_staked_at: 0, last_epoch_checked: 0}
        } else {
            *0x2::linked_table::borrow<address, UserJwltokenInfo>(&arg0.user_jwltoken_info, arg1)
        }
    }

    public fun initialize(arg0: &0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::ownership::OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                            : 0x2::object::new(arg2),
            version                       : 1,
            is_active                     : true,
            total_jwlxmn_converted_amount : 0,
            epoch_period_ms               : 604800000,
            locking_period_ms             : 604800000,
            current_epoch                 : 1,
            epoch_rewards                 : 0,
            epoch_start_time              : 0x2::clock::timestamp_ms(arg1),
            last_epoch_got_rewards        : 0,
            total_reward_amount           : 0,
            reward_amount                 : 0,
            total_jwlxmn_staked           : 0,
            total_jwlxmn_compounded       : 0,
            total_stakers                 : 0,
            total_stakers_checked         : 0,
            jwlxmn_vault                  : 0x2::balance::zero<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN>(),
            user_jwltoken_info            : 0x2::linked_table::new<address, UserJwltokenInfo>(arg2),
            user_stake_amount             : 0x2::table::new<0x1::string::String, u64>(arg2),
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun set_user_jwlxmn_stake_data(arg0: &0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::ownership::OwnerCap, arg1: &mut GlobalConfig, arg2: 0x1::string::String, arg3: u64) {
        assert_active(arg1);
        assert_version(arg1);
        if (!0x2::table::contains<0x1::string::String, u64>(&arg1.user_stake_amount, arg2)) {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.user_stake_amount, arg2, arg3);
        };
        let v0 = SetUserJwlxmnStakeDataEvent{
            user_mvx_address : arg2,
            stake_amount     : arg3,
        };
        0x2::event::emit<SetUserJwlxmnStakeDataEvent>(v0);
    }

    public fun stake(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = &mut arg0.user_jwltoken_info;
        check_user_jwltoken_info(v0, 0x2::tx_context::sender(arg3));
        let v1 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg0.user_jwltoken_info, 0x2::tx_context::sender(arg3));
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0x2::coin::value<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN>(&arg1);
        0x2::coin::put<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN>(&mut arg0.jwlxmn_vault, arg1);
        if (v1.jwltoken_staked == 0) {
            arg0.total_stakers = arg0.total_stakers + 1;
        };
        arg0.total_jwlxmn_staked = arg0.total_jwlxmn_staked + v3;
        v1.jwltoken_staked = v1.jwltoken_staked + v3;
        v1.last_staked_at = v2;
        let v4 = StakeJwlxmnEvent{
            user              : 0x2::tx_context::sender(arg3),
            amount            : v3,
            staked_at         : 0x2::clock::timestamp_ms(arg2),
            current_timestamp : v2,
        };
        0x2::event::emit<StakeJwlxmnEvent>(v4);
    }

    public fun unstake(arg0: &mut GlobalConfig, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN> {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg0.user_jwltoken_info, 0x2::tx_context::sender(arg3));
        assert!(v0.jwltoken_staked >= arg2, 109);
        if (v0.jwltoken_staked == arg2) {
            arg0.total_stakers = arg0.total_stakers - 1;
        };
        arg0.total_jwlxmn_staked = arg0.total_jwlxmn_staked - arg2;
        v0.jwltoken_staked = v0.jwltoken_staked - arg2;
        let v1 = UnstakeJwlxmnEvent{
            user              : 0x2::tx_context::sender(arg3),
            amount            : arg2,
            unstaked_at       : 0x2::clock::timestamp_ms(arg1),
            current_timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<UnstakeJwlxmnEvent>(v1);
        0x2::coin::take<0xdecf77893745212802a29752bdb333b49abd9deef9ff7c18ab1ba515eb9cb696::jwlxmn::JWLXMN>(&mut arg0.jwlxmn_vault, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

