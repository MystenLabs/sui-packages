module 0x2f71cffb647ee128fbd31b530c32f98ca00cc58e42d72fd86b8bb995d8125b10::campaign_reward {
    struct CAMPAIGN_REWARD has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct Campaign has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        paused: bool,
        start_time: u64,
        end_time: u64,
        total_rewards: 0x2::table::Table<address, u64>,
        rewards_remaining: 0x2::table::Table<address, u64>,
        individual_rewards: 0x2::table::Table<address, u64>,
        claimed_pools: 0x2::table::Table<address, vector<address>>,
        whitelisted: 0x2::table::Table<address, bool>,
        claimed: 0x2::table::Table<address, bool>,
    }

    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        coin_type: 0x1::type_name::TypeName,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        wl_manager: vector<address>,
        total_pools: u64,
        pools: vector<address>,
    }

    struct ClaimEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        user: address,
        reward: u64,
    }

    struct CreateCampaignEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        name: vector<u8>,
        start_time: u64,
        end_time: u64,
        pools: vector<address>,
        total_rewards: vector<u64>,
        individual_rewards: vector<u64>,
    }

    struct CreateRewardPoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        total_reward: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct UpdateStartEndTime has copy, drop {
        campaign_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
    }

    struct AddWhiteListEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        users: vector<address>,
    }

    struct RemoveWhiteListEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        users: vector<address>,
    }

    struct StartPauseEvent has copy, drop {
        paused: bool,
    }

    struct StartPauseCampaignEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        paused: bool,
    }

    struct AddWlManagerEvent has copy, drop {
        users: vector<address>,
    }

    struct RemoveWlManagerEvent has copy, drop {
        users: vector<address>,
    }

    struct UpdateCampaignTotalRewardEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        pools: vector<address>,
        total_rewards: vector<u64>,
    }

    struct UpdateCampaignIndividualRewardEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        pools: vector<address>,
        individual_reward: vector<u64>,
    }

    struct DepositPoolGameEvent has copy, drop {
        owner: address,
        pool: 0x2::object::ID,
        reward: u64,
    }

    struct EmergencyWithdrawPoolGameEvent has copy, drop {
        owner: address,
        pool: 0x2::object::ID,
        reward: u64,
    }

    public fun add_whitelist(arg0: &mut Config, arg1: &mut Campaign, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.wl_manager, &v0), 1004);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (!0x2::table::contains<address, bool>(&arg1.whitelisted, v2)) {
                0x2::table::add<address, bool>(&mut arg1.whitelisted, v2, true);
            };
            v1 = v1 + 1;
        };
        let v3 = AddWhiteListEvent{
            campaign_id : 0x2::object::id<Campaign>(arg1),
            users       : arg2,
        };
        0x2::event::emit<AddWhiteListEvent>(v3);
    }

    public fun add_wl_manager(arg0: &AdminCap, arg1: &mut Config, arg2: vector<address>) {
        assert!(arg1.version == 1, 1002);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (!0x1::vector::contains<address>(&arg1.wl_manager, v1)) {
                0x1::vector::push_back<address>(&mut arg1.wl_manager, *v1);
            };
            v0 = v0 + 1;
        };
        let v2 = AddWlManagerEvent{users: arg2};
        0x2::event::emit<AddWlManagerEvent>(v2);
    }

    public fun claim<T0>(arg0: &Config, arg1: &mut Campaign, arg2: &mut RewardPool<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        assert!(!arg0.paused, 1003);
        assert!(!arg1.paused, 1003);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.start_time <= v0, 1006);
        assert!(v0 <= arg1.end_time, 1010);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, bool>(&arg1.whitelisted, v1), 1009);
        assert!(!0x2::table::contains<address, bool>(&arg1.claimed, v1), 1007);
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg1.rewards_remaining, 0x2::object::id_address<RewardPool<T0>>(arg2));
        assert!(*v2 > 0, 1005);
        let v3 = *0x2::table::borrow<address, u64>(&arg1.individual_rewards, 0x2::object::id_address<RewardPool<T0>>(arg2));
        assert!(v3 <= *v2, 1000);
        *v2 = *v2 - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, v3), arg4), v1);
        let v4 = if (0x2::table::contains<address, vector<address>>(&arg1.claimed_pools, v1)) {
            0x2::table::remove<address, vector<address>>(&mut arg1.claimed_pools, v1)
        } else {
            0x1::vector::empty<address>()
        };
        let v5 = v4;
        let v6 = 0x2::object::id_address<RewardPool<T0>>(arg2);
        assert!(!0x1::vector::contains<address>(&v5, &v6), 1012);
        0x1::vector::push_back<address>(&mut v5, 0x2::object::id_address<RewardPool<T0>>(arg2));
        if (0x1::vector::length<address>(&v5) == 0x2::table::length<address, u64>(&arg1.total_rewards)) {
            0x2::table::add<address, bool>(&mut arg1.claimed, v1, true);
        };
        0x2::table::add<address, vector<address>>(&mut arg1.claimed_pools, v1, v5);
        let v7 = ClaimEvent{
            campaign_id : 0x2::object::id<Campaign>(arg1),
            pool_id     : 0x2::object::id<RewardPool<T0>>(arg2),
            user        : v1,
            reward      : v3,
        };
        0x2::event::emit<ClaimEvent>(v7);
    }

    public fun create_campaign(arg0: &AdminCap, arg1: &Config, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<address>, arg6: vector<u64>, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1002);
        assert!(arg3 < arg4, 1008);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg6) && 0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg7), 1008);
        let v0 = 0;
        let v1 = 0x2::table::new<address, u64>(arg8);
        let v2 = 0x2::table::new<address, u64>(arg8);
        let v3 = 0x2::table::new<address, u64>(arg8);
        while (v0 < 0x1::vector::length<address>(&arg5)) {
            let v4 = *0x1::vector::borrow<address>(&arg5, v0);
            0x2::table::add<address, u64>(&mut v1, v4, *0x1::vector::borrow<u64>(&arg6, v0));
            0x2::table::add<address, u64>(&mut v2, v4, *0x1::vector::borrow<u64>(&arg6, v0));
            0x2::table::add<address, u64>(&mut v3, v4, *0x1::vector::borrow<u64>(&arg7, v0));
            v0 = v0 + 1;
        };
        let v5 = Campaign{
            id                 : 0x2::object::new(arg8),
            name               : 0x1::string::utf8(arg2),
            paused             : false,
            start_time         : arg3,
            end_time           : arg4,
            total_rewards      : v1,
            rewards_remaining  : v2,
            individual_rewards : v3,
            claimed_pools      : 0x2::table::new<address, vector<address>>(arg8),
            whitelisted        : 0x2::table::new<address, bool>(arg8),
            claimed            : 0x2::table::new<address, bool>(arg8),
        };
        let v6 = CreateCampaignEvent{
            campaign_id        : 0x2::object::id<Campaign>(&v5),
            name               : arg2,
            start_time         : arg3,
            end_time           : arg4,
            pools              : arg5,
            total_rewards      : arg6,
            individual_rewards : arg7,
        };
        0x2::event::emit<CreateCampaignEvent>(v6);
        0x2::transfer::public_share_object<Campaign>(v5);
    }

    public fun create_reward_pool<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1002);
        let v0 = RewardPool<T0>{
            id        : 0x2::object::new(arg3),
            balance   : 0x2::coin::into_balance<T0>(arg2),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x1::vector::push_back<address>(&mut arg1.pools, 0x2::object::id_address<RewardPool<T0>>(&v0));
        arg1.total_pools = arg1.total_pools + 1;
        let v1 = CreateRewardPoolEvent{
            pool_id      : 0x2::object::id<RewardPool<T0>>(&v0),
            total_reward : 0x2::balance::value<T0>(&v0.balance),
            coin_type    : v0.coin_type,
        };
        0x2::event::emit<CreateRewardPoolEvent>(v1);
        0x2::transfer::public_share_object<RewardPool<T0>>(v0);
    }

    public fun deposit_reward_pool<T0>(arg0: &TreasureCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut RewardPool<T0>, arg3: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = DepositPoolGameEvent{
            owner  : 0x2::tx_context::sender(arg3),
            pool   : 0x2::object::id<RewardPool<T0>>(arg2),
            reward : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositPoolGameEvent>(v0);
    }

    public fun emergency_reward_withdraw_pool<T0>(arg0: &TreasureCap, arg1: &mut RewardPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::balance::value<T0>(&arg1.balance) > 0, 1011);
        let v1 = 0x2::balance::value<T0>(&arg1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg2), v0);
        let v2 = EmergencyWithdrawPoolGameEvent{
            owner  : v0,
            pool   : 0x2::object::id<RewardPool<T0>>(arg1),
            reward : v1,
        };
        0x2::event::emit<EmergencyWithdrawPoolGameEvent>(v2);
    }

    public fun get_reward_balance<T0>(arg0: &RewardPool<T0>) : u128 {
        (0x2::balance::value<T0>(&arg0.balance) as u128)
    }

    fun init(arg0: CAMPAIGN_REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TreasureCap>(v2, v0);
        let v3 = Config{
            id          : 0x2::object::new(arg1),
            version     : 1,
            paused      : false,
            wl_manager  : 0x1::vector::empty<address>(),
            total_pools : 0,
            pools       : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<Config>(v3);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 1001);
        arg1.version = 1;
    }

    public fun pause(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert!(arg1.version == 1, 1002);
        assert!(arg2 != arg1.paused, 1008);
        arg1.paused = arg2;
        let v0 = StartPauseEvent{paused: arg2};
        0x2::event::emit<StartPauseEvent>(v0);
    }

    public fun pause_campaign(arg0: &AdminCap, arg1: &mut Config, arg2: &mut Campaign, arg3: bool) {
        assert!(arg1.version == 1, 1002);
        assert!(arg3 != arg2.paused, 1008);
        arg2.paused = arg3;
        let v0 = StartPauseCampaignEvent{
            campaign_id : 0x2::object::id<Campaign>(arg2),
            paused      : arg3,
        };
        0x2::event::emit<StartPauseCampaignEvent>(v0);
    }

    public fun remove_whitelist(arg0: &mut Config, arg1: &mut Campaign, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.wl_manager, &v0), 1004);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (0x2::table::contains<address, bool>(&arg1.whitelisted, v2)) {
                0x2::table::remove<address, bool>(&mut arg1.whitelisted, v2);
            };
            v1 = v1 + 1;
        };
        let v3 = RemoveWhiteListEvent{
            campaign_id : 0x2::object::id<Campaign>(arg1),
            users       : arg2,
        };
        0x2::event::emit<RemoveWhiteListEvent>(v3);
    }

    public fun remove_wl_manager(arg0: &AdminCap, arg1: &mut Config, arg2: vector<address>) {
        assert!(arg1.version == 1, 1002);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (0x1::vector::contains<address>(&arg1.wl_manager, v1)) {
                let (_, v3) = 0x1::vector::index_of<address>(&arg1.wl_manager, v1);
                0x1::vector::remove<address>(&mut arg1.wl_manager, v3);
            };
            v0 = v0 + 1;
        };
        let v4 = RemoveWlManagerEvent{users: arg2};
        0x2::event::emit<RemoveWlManagerEvent>(v4);
    }

    public fun update_campaign_individual_reward(arg0: &AdminCap, arg1: &Config, arg2: &mut Campaign, arg3: vector<address>, arg4: vector<u64>) {
        assert!(arg1.version == 1, 1002);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 1008);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            if (0x2::table::contains<address, u64>(&arg2.individual_rewards, v1)) {
                0x2::table::remove<address, u64>(&mut arg2.individual_rewards, v1);
            };
            0x2::table::add<address, u64>(&mut arg2.individual_rewards, v1, *0x1::vector::borrow<u64>(&arg4, v0));
            v0 = v0 + 1;
        };
        let v2 = UpdateCampaignIndividualRewardEvent{
            campaign_id       : 0x2::object::id<Campaign>(arg2),
            pools             : arg3,
            individual_reward : arg4,
        };
        0x2::event::emit<UpdateCampaignIndividualRewardEvent>(v2);
    }

    public fun update_campaign_total_reward(arg0: &AdminCap, arg1: &Config, arg2: &mut Campaign, arg3: vector<address>, arg4: vector<u64>) {
        assert!(arg1.version == 1, 1002);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 1008);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            if (0x2::table::contains<address, u64>(&arg2.total_rewards, v1)) {
                0x2::table::remove<address, u64>(&mut arg2.total_rewards, v1);
            };
            0x2::table::add<address, u64>(&mut arg2.total_rewards, v1, *0x1::vector::borrow<u64>(&arg4, v0));
            v0 = v0 + 1;
        };
        let v2 = UpdateCampaignTotalRewardEvent{
            campaign_id   : 0x2::object::id<Campaign>(arg2),
            pools         : arg3,
            total_rewards : arg4,
        };
        0x2::event::emit<UpdateCampaignTotalRewardEvent>(v2);
    }

    public fun update_start_end_time(arg0: &AdminCap, arg1: &mut Config, arg2: &mut Campaign, arg3: u64, arg4: u64) {
        assert!(arg1.version == 1, 1002);
        assert!(arg3 < arg4, 1008);
        arg2.start_time = arg3;
        arg2.end_time = arg4;
        let v0 = UpdateStartEndTime{
            campaign_id : 0x2::object::id<Campaign>(arg2),
            start_time  : arg3,
            end_time    : arg4,
        };
        0x2::event::emit<UpdateStartEndTime>(v0);
    }

    // decompiled from Move bytecode v6
}

