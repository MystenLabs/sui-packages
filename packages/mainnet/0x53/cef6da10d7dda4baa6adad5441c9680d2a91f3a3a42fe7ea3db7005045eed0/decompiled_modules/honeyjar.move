module 0x53cef6da10d7dda4baa6adad5441c9680d2a91f3a3a42fe7ea3db7005045eed0::honeyjar {
    struct HONEYJAR has drop {
        dummy_field: bool,
    }

    struct HoneyJarAdminCap has store, key {
        id: 0x2::object::UID,
        chef_id: 0x1::option::Option<address>,
    }

    struct HoneyJarPointsCap has store, key {
        id: 0x2::object::UID,
    }

    struct HoneyJarFeeClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketplaceChef has key {
        id: 0x2::object::UID,
        mint_fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        cycle_duration: u64,
        honeyjars: 0x2::linked_table::LinkedTable<address, address>,
        claim_locked: bool,
        activity_incentives_cap: 0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey_yield::ClaimHoneyCap,
        activity_rewards: 0x2::balance::Balance<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>,
        last_claim_ts: u64,
        global_claim_index: u256,
        total_distributed: u64,
        active_points: u64,
        trading_incentives_cap: 0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey_yield::ClaimHoneyCap,
        trading_rewards: 0x2::balance::Balance<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>,
        cur_cycle: u64,
        cur_cycle_points: u64,
        cur_cycle_rewards: u64,
        cycle_info: 0x2::linked_table::LinkedTable<u64, CycleInfo>,
        bag: 0x2::bag::Bag,
        version: u64,
    }

    struct CycleInfo has store {
        honey_rewards: u64,
        total_points: u64,
    }

    struct HoneyJar has key {
        id: 0x2::object::UID,
        index: u64,
        created_at: u64,
        owner: address,
        claim_index: u256,
        claimable_rewards: u64,
        total_claimed_rewards: u64,
        active_points: u64,
        cur_cycle: u64,
        cur_cycle_points: u64,
        claimable_trading_rewards: u64,
        amm_trade_points: 0x2::linked_table::LinkedTable<address, AmmUserPoints>,
        claimable_amm_rewards: 0x2::balance::Balance<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>,
        bag: 0x2::bag::Bag,
        version: u64,
    }

    struct AmmUserPoints has copy, drop, store {
        points: u64,
        cycle: u64,
    }

    struct ClaimProtocolEarnings has copy, drop {
        user: address,
        claimed_rewards: u64,
    }

    struct PreLaunchCampaignFinished has copy, drop {
        active_points: u64,
    }

    struct HoneyJarMinted has copy, drop {
        honeyjar_id: address,
        owner: address,
        index: u64,
        timestamp: u64,
    }

    struct HoneyJarPointsAwarded has copy, drop {
        honeyjar_id: address,
        owner: address,
        points_earned: u64,
        box_total_points: u64,
    }

    struct HoneyJarPointsRemoved has copy, drop {
        honeyjar_id: address,
        owner: address,
        points_removed: u64,
        box_total_points: u64,
    }

    struct HoneyJarHoneyClaimed has copy, drop {
        honeyjar_id: address,
        owner: address,
        claimed_activity_rewards: u64,
        claimed_trading_rewards: u64,
        claimed_amm_rewards: u64,
        total_claimed_rewards: u64,
    }

    struct NftTradingIncentivesCycleEnded has copy, drop {
        cycle: u64,
        total_points: u64,
        honey_rewards: u64,
    }

    struct UserNftTradingRewardsUpdated has copy, drop {
        honeyjar_id: address,
        owner: address,
        trading_rewards: u64,
        claimable_trading_rewards: u64,
    }

    struct HoneyJarPointsTradeAwarded has copy, drop {
        honeyjar_id: address,
        owner: address,
        points_earned: u64,
        cur_cycle_points: u64,
    }

    public fun claim_honey(arg0: &0x2::clock::Clock, arg1: &mut MarketplaceChef, arg2: &mut 0x53cef6da10d7dda4baa6adad5441c9680d2a91f3a3a42fe7ea3db7005045eed0::honey_manager::HoneyManager, arg3: &mut HoneyJar, arg4: &mut 0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey_yield::HoneyYield, arg5: &mut 0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey_yield::FeeCollector<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>, arg6: &mut 0x2::token::TokenPolicy<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>, arg7: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        box_validation_check(arg3);
        assert!(arg3.owner == 0x2::tx_context::sender(arg7), 4014);
        assert!(!arg1.claim_locked, 4015);
        increment_honeyjar_rewards(arg0, arg2, arg1, arg3);
        increment_honeyjar_trading_rewards(arg0, arg2, arg1, arg3, arg7);
        let v0 = if (arg3.claimable_rewards > 0) {
            true
        } else if (arg3.claimable_trading_rewards > 0) {
            true
        } else {
            0x2::balance::value<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&arg3.claimable_amm_rewards) > 0
        };
        if (v0) {
            let v1 = 0x2::balance::split<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&mut arg1.activity_rewards, arg3.claimable_rewards);
            0x2::balance::join<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&mut v1, 0x2::balance::split<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&mut arg1.trading_rewards, arg3.claimable_trading_rewards));
            0x2::balance::join<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&mut v1, 0x2::balance::withdraw_all<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&mut arg3.claimable_amm_rewards));
            0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::token_rules::from_coin_and_transfer<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(0x2::coin::from_balance<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(v1, arg7), arg5, arg4, arg6, 0x2::tx_context::sender(arg7), arg7);
            arg3.total_claimed_rewards = arg3.total_claimed_rewards + arg3.claimable_rewards + arg3.claimable_trading_rewards;
            let v2 = HoneyJarHoneyClaimed{
                honeyjar_id              : 0x2::object::uid_to_address(&arg3.id),
                owner                    : arg3.owner,
                claimed_activity_rewards : arg3.claimable_rewards,
                claimed_trading_rewards  : arg3.claimable_trading_rewards,
                claimed_amm_rewards      : 0x2::balance::value<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&arg3.claimable_amm_rewards),
                total_claimed_rewards    : arg3.total_claimed_rewards,
            };
            0x2::event::emit<HoneyJarHoneyClaimed>(v2);
            arg3.claimable_rewards = 0;
            arg3.claimable_trading_rewards = 0;
        };
    }

    public fun add_to_honeyjar(arg0: &HoneyJarPointsCap, arg1: &0x2::clock::Clock, arg2: &mut MarketplaceChef, arg3: &mut 0x53cef6da10d7dda4baa6adad5441c9680d2a91f3a3a42fe7ea3db7005045eed0::honey_manager::HoneyManager, arg4: &mut HoneyJar, arg5: u64) {
        validation_check(arg2);
        box_validation_check(arg4);
        increment_honeyjar_rewards(arg1, arg3, arg2, arg4);
        arg2.active_points = arg2.active_points + arg5;
        arg4.active_points = arg4.active_points + arg5;
        let v0 = HoneyJarPointsAwarded{
            honeyjar_id      : 0x2::object::uid_to_address(&arg4.id),
            owner            : arg4.owner,
            points_earned    : arg5,
            box_total_points : arg4.active_points,
        };
        0x2::event::emit<HoneyJarPointsAwarded>(v0);
    }

    public fun add_trade_points_to_honeyjar(arg0: &HoneyJarPointsCap, arg1: &0x2::clock::Clock, arg2: &mut MarketplaceChef, arg3: &mut 0x53cef6da10d7dda4baa6adad5441c9680d2a91f3a3a42fe7ea3db7005045eed0::honey_manager::HoneyManager, arg4: &mut HoneyJar, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        validation_check(arg2);
        box_validation_check(arg4);
        increment_honeyjar_trading_rewards(arg1, arg3, arg2, arg4, arg6);
        arg2.cur_cycle_points = arg2.cur_cycle_points + arg5;
        arg4.cur_cycle_points = arg4.cur_cycle_points + arg5;
        let v0 = HoneyJarPointsTradeAwarded{
            honeyjar_id      : 0x2::object::uid_to_address(&arg4.id),
            owner            : arg4.owner,
            points_earned    : arg5,
            cur_cycle_points : arg4.cur_cycle_points,
        };
        0x2::event::emit<HoneyJarPointsTradeAwarded>(v0);
    }

    public fun amm_add_claimable_rewards(arg0: &mut HoneyJar, arg1: 0x2::balance::Balance<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>) {
        0x2::balance::join<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&mut arg0.claimable_amm_rewards, arg1);
    }

    public fun amm_add_trade_points(arg0: &mut HoneyJar, arg1: address, arg2: u64, arg3: u64) : bool {
        box_validation_check(arg0);
        let v0 = false;
        if (!0x2::linked_table::contains<address, AmmUserPoints>(&arg0.amm_trade_points, arg1)) {
            let v1 = AmmUserPoints{
                points : 0,
                cycle  : arg2,
            };
            0x2::linked_table::push_back<address, AmmUserPoints>(&mut arg0.amm_trade_points, arg1, v1);
        };
        let v2 = 0x2::linked_table::borrow_mut<address, AmmUserPoints>(&mut arg0.amm_trade_points, arg1);
        if (v2.cycle == arg2) {
            v2.points = v2.points + arg3;
            v0 = true;
        };
        v0
    }

    public fun amm_get_user_points(arg0: &HoneyJar, arg1: address) : (u64, u64) {
        if (0x2::linked_table::contains<address, AmmUserPoints>(&arg0.amm_trade_points, arg1)) {
            let v2 = 0x2::linked_table::borrow<address, AmmUserPoints>(&arg0.amm_trade_points, arg1);
            (v2.points, v2.cycle)
        } else {
            (0, 0)
        }
    }

    public fun amm_reset_user_points(arg0: &mut HoneyJar, arg1: address, arg2: u64) {
        if (!0x2::linked_table::contains<address, AmmUserPoints>(&arg0.amm_trade_points, arg1)) {
            let v0 = AmmUserPoints{
                points : 0,
                cycle  : arg2,
            };
            0x2::linked_table::push_back<address, AmmUserPoints>(&mut arg0.amm_trade_points, arg1, v0);
            return
        };
        let v1 = 0x2::linked_table::borrow_mut<address, AmmUserPoints>(&mut arg0.amm_trade_points, arg1);
        v1.points = 0;
        v1.cycle = arg2;
    }

    public fun box_validation_check(arg0: &mut HoneyJar) {
        assert!(arg0.version == 0, 4007);
    }

    public fun claim_sui_collected(arg0: &mut MarketplaceChef, arg1: &HoneyJarFeeClaimCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = ClaimProtocolEarnings{
            user            : arg2,
            claimed_rewards : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<ClaimProtocolEarnings>(v0);
        0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2, arg3);
    }

    public fun contains_user(arg0: &MarketplaceChef, arg1: address) : bool {
        0x2::linked_table::contains<address, address>(&arg0.honeyjars, arg1)
    }

    public fun delete_honeyjar_points_cap(arg0: HoneyJarPointsCap) {
        let HoneyJarPointsCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun finish_prelaunch_campaign(arg0: &HoneyJarAdminCap, arg1: &mut MarketplaceChef) {
        validation_check(arg1);
        assert!(arg1.claim_locked, 4011);
        arg1.claim_locked = false;
        let v0 = PreLaunchCampaignFinished{active_points: arg1.active_points};
        0x2::event::emit<PreLaunchCampaignFinished>(v0);
    }

    public fun get_active_points(arg0: &HoneyJar) : u64 {
        arg0.active_points
    }

    public fun get_chef_active_points(arg0: &MarketplaceChef) : u64 {
        arg0.active_points
    }

    public fun get_chef_claim_locked(arg0: &MarketplaceChef) : bool {
        arg0.claim_locked
    }

    public fun get_claimable_amm_rewards(arg0: &HoneyJar) : u64 {
        0x2::balance::value<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&arg0.claimable_amm_rewards)
    }

    public fun get_claimable_rewards(arg0: &HoneyJar) : u64 {
        arg0.claimable_rewards
    }

    public fun get_marketplace_chef_id(arg0: &MarketplaceChef) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_marketplace_chef_info(arg0: &MarketplaceChef) : (u64, u64, u64, bool, u64, u64, u256, u64, u64) {
        (arg0.mint_fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 0x2::linked_table::length<address, address>(&arg0.honeyjars), arg0.claim_locked, 0x2::balance::value<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&arg0.activity_rewards), arg0.last_claim_ts, arg0.global_claim_index, arg0.total_distributed, arg0.active_points)
    }

    public fun get_mint_fee(arg0: &MarketplaceChef) : u64 {
        arg0.mint_fee
    }

    public fun get_owner(arg0: &HoneyJar) : address {
        arg0.owner
    }

    public fun get_total_claimed_rewards(arg0: &HoneyJar) : u64 {
        arg0.total_claimed_rewards
    }

    fun increment_global_index(arg0: &0x2::clock::Clock, arg1: &mut 0x53cef6da10d7dda4baa6adad5441c9680d2a91f3a3a42fe7ea3db7005045eed0::honey_manager::HoneyManager, arg2: &mut MarketplaceChef) {
        if (arg2.active_points == 0) {
            return
        };
        let v0 = 0x53cef6da10d7dda4baa6adad5441c9680d2a91f3a3a42fe7ea3db7005045eed0::honey_manager::claim_honey(&mut arg2.activity_incentives_cap, arg1, arg0);
        let v1 = 0x2::balance::value<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&v0);
        arg2.global_claim_index = arg2.global_claim_index + 0xc9a6f26e30f389cb6e436096295a39956f0f4a28d47067c0ab812869030896e1::math::mul_div_u256((v1 as u256), (1000000000000 as u256), (arg2.active_points as u256));
        arg2.last_claim_ts = 0x2::clock::timestamp_ms(arg0);
        arg2.total_distributed = arg2.total_distributed + v1;
        0x2::balance::join<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&mut arg2.activity_rewards, v0);
    }

    fun increment_honeyjar_rewards(arg0: &0x2::clock::Clock, arg1: &mut 0x53cef6da10d7dda4baa6adad5441c9680d2a91f3a3a42fe7ea3db7005045eed0::honey_manager::HoneyManager, arg2: &mut MarketplaceChef, arg3: &mut HoneyJar) {
        increment_global_index(arg0, arg1, arg2);
        arg3.claimable_rewards = arg3.claimable_rewards + (0xc9a6f26e30f389cb6e436096295a39956f0f4a28d47067c0ab812869030896e1::math::mul_div_u256(arg2.global_claim_index - arg3.claim_index, (arg3.active_points as u256), (1000000000000 as u256)) as u64);
        arg3.claim_index = arg2.global_claim_index;
    }

    fun increment_honeyjar_trading_rewards(arg0: &0x2::clock::Clock, arg1: &mut 0x53cef6da10d7dda4baa6adad5441c9680d2a91f3a3a42fe7ea3db7005045eed0::honey_manager::HoneyManager, arg2: &mut MarketplaceChef, arg3: &mut HoneyJar, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        if (arg2.cur_cycle + arg2.cycle_duration <= v0) {
            let v1 = arg2.cur_cycle_points;
            let v2 = arg2.cur_cycle_rewards;
            let v3 = CycleInfo{
                honey_rewards : v2,
                total_points  : v1,
            };
            0x2::linked_table::push_back<u64, CycleInfo>(&mut arg2.cycle_info, arg2.cur_cycle, v3);
            let v4 = NftTradingIncentivesCycleEnded{
                cycle         : arg2.cur_cycle,
                total_points  : v1,
                honey_rewards : v2,
            };
            0x2::event::emit<NftTradingIncentivesCycleEnded>(v4);
            arg2.cur_cycle = v0;
            arg2.cur_cycle_points = 0;
            arg2.cur_cycle_rewards = 0;
        };
        let v5 = 0x53cef6da10d7dda4baa6adad5441c9680d2a91f3a3a42fe7ea3db7005045eed0::honey_manager::claim_honey(&mut arg2.trading_incentives_cap, arg1, arg0);
        arg2.cur_cycle_rewards = arg2.cur_cycle_rewards + 0x2::balance::value<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&v5);
        0x2::balance::join<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&mut arg2.trading_rewards, v5);
        if (arg3.cur_cycle != arg2.cur_cycle) {
            if (0x2::linked_table::contains<u64, CycleInfo>(&arg2.cycle_info, arg3.cur_cycle)) {
                let v6 = 0x2::linked_table::borrow<u64, CycleInfo>(&arg2.cycle_info, arg3.cur_cycle);
                if (v6.total_points > 0 && arg3.cur_cycle_points > 0) {
                    let v7 = (0xc9a6f26e30f389cb6e436096295a39956f0f4a28d47067c0ab812869030896e1::math::mul_div_u128((arg3.cur_cycle_points as u128), (v6.honey_rewards as u128), (v6.total_points as u128)) as u64);
                    arg3.claimable_trading_rewards = arg3.claimable_trading_rewards + v7;
                    if (v7 > 0) {
                        let v8 = UserNftTradingRewardsUpdated{
                            honeyjar_id               : 0x2::object::uid_to_address(&arg3.id),
                            owner                     : arg3.owner,
                            trading_rewards           : v7,
                            claimable_trading_rewards : arg3.claimable_trading_rewards,
                        };
                        0x2::event::emit<UserNftTradingRewardsUpdated>(v8);
                    };
                };
            };
            arg3.cur_cycle = arg2.cur_cycle;
            arg3.cur_cycle_points = 0;
        };
    }

    fun init(arg0: HONEYJAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"website"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"owner"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"active_points"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"claimable_rewards"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"total_claimed_rewards"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"HONEYJAR #{index}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A points system that rewards participation, engagement, and value-driven actions on HoneyPlay's marketplace."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.honeyplay.fun/static/honeyJar.webp"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://honeyplay.fun"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Owner: {owner}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Active Points: {active_points}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claimable Rewards: {claimable_rewards}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Total Claimed Rewards: {total_claimed_rewards}"));
        let v4 = 0x2::package::claim<HONEYJAR>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<HoneyJar>(&v4, v0, v2, arg1);
        0x2::display::update_version<HoneyJar>(&mut v5);
        let v6 = HoneyJarAdminCap{
            id      : 0x2::object::new(arg1),
            chef_id : 0x1::option::none<address>(),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HoneyJar>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<HoneyJarAdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = HoneyJarFeeClaimCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<HoneyJarFeeClaimCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun init_marketplace_chef(arg0: &mut HoneyJarAdminCap, arg1: 0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey_yield::ClaimHoneyCap, arg2: 0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey_yield::ClaimHoneyCap, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<address>(&arg0.chef_id), 4000);
        let v0 = MarketplaceChef{
            id                      : 0x2::object::new(arg5),
            mint_fee                : arg4,
            balance                 : 0x2::balance::zero<0x2::sui::SUI>(),
            cycle_duration          : 7,
            honeyjars               : 0x2::linked_table::new<address, address>(arg5),
            claim_locked            : true,
            activity_incentives_cap : arg1,
            activity_rewards        : 0x2::balance::zero<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(),
            last_claim_ts           : 0x2::clock::timestamp_ms(arg3),
            global_claim_index      : 0,
            total_distributed       : 0,
            active_points           : 0,
            trading_incentives_cap  : arg2,
            trading_rewards         : 0x2::balance::zero<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(),
            cur_cycle               : 0x2::tx_context::epoch(arg5),
            cur_cycle_points        : 0,
            cur_cycle_rewards       : 0,
            cycle_info              : 0x2::linked_table::new<u64, CycleInfo>(arg5),
            bag                     : 0x2::bag::new(arg5),
            version                 : 0,
        };
        arg0.chef_id = 0x1::option::some<address>(0x2::object::uid_to_address(&v0.id));
        0x2::transfer::share_object<MarketplaceChef>(v0);
    }

    public fun is_claim_locked(arg0: &MarketplaceChef) : bool {
        arg0.claim_locked
    }

    public fun mint_honeyjar(arg0: &0x2::clock::Clock, arg1: &mut MarketplaceChef, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::linked_table::contains<address, address>(&arg1.honeyjars, v0), 4009);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.mint_fee, 4012);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, arg1.mint_fee));
        0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg3), arg3);
        let v2 = HoneyJar{
            id                        : 0x2::derived_object::claim<address>(&mut arg1.id, v0),
            index                     : 0x2::linked_table::length<address, address>(&arg1.honeyjars),
            created_at                : 0x2::clock::timestamp_ms(arg0),
            owner                     : v0,
            claim_index               : arg1.global_claim_index,
            claimable_rewards         : 0,
            total_claimed_rewards     : 0,
            active_points             : 0,
            cur_cycle                 : arg1.cur_cycle,
            cur_cycle_points          : 0,
            claimable_trading_rewards : 0,
            amm_trade_points          : 0x2::linked_table::new<address, AmmUserPoints>(arg3),
            claimable_amm_rewards     : 0x2::balance::zero<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(),
            bag                       : 0x2::bag::new(arg3),
            version                   : 0,
        };
        0x2::linked_table::push_back<address, address>(&mut arg1.honeyjars, v0, 0x2::object::uid_to_address(&v2.id));
        let v3 = HoneyJarMinted{
            honeyjar_id : 0x2::object::uid_to_address(&v2.id),
            owner       : v0,
            index       : v2.index,
            timestamp   : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<HoneyJarMinted>(v3);
        0x2::transfer::share_object<HoneyJar>(v2);
    }

    public fun mint_honeyjar_points_cap(arg0: &HoneyJarAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HoneyJarPointsCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<HoneyJarPointsCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun query_activity_rewards_state(arg0: &MarketplaceChef) : (u256, u64, u64, u64) {
        (arg0.global_claim_index, arg0.total_distributed, arg0.active_points, 0x2::balance::value<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&arg0.activity_rewards))
    }

    public fun query_nft_trading_cycle_info(arg0: &MarketplaceChef, arg1: u64) : (u64, u64) {
        if (0x2::linked_table::contains<u64, CycleInfo>(&arg0.cycle_info, arg1)) {
            let v2 = 0x2::linked_table::borrow<u64, CycleInfo>(&arg0.cycle_info, arg1);
            (v2.total_points, v2.honey_rewards)
        } else {
            (0, 0)
        }
    }

    public fun query_nft_trading_cycle_state(arg0: &MarketplaceChef) : (u64, u64, u64, u64, u64) {
        (arg0.cur_cycle, arg0.cycle_duration, arg0.cur_cycle_points, arg0.cur_cycle_rewards, 0x2::balance::value<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&arg0.trading_rewards))
    }

    public fun query_user_activity_rewards_state(arg0: &HoneyJar) : (u64, u256, u64, u64) {
        (arg0.active_points, arg0.claim_index, arg0.claimable_rewards, arg0.total_claimed_rewards)
    }

    public fun query_user_all_rewards(arg0: &HoneyJar) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.active_points, arg0.claimable_rewards, arg0.cur_cycle, arg0.cur_cycle_points, arg0.claimable_trading_rewards, 0x2::balance::value<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&arg0.claimable_amm_rewards), arg0.total_claimed_rewards)
    }

    public fun query_user_nft_trading_claimable_for_cycle(arg0: &MarketplaceChef, arg1: &HoneyJar, arg2: u64) : u64 {
        if (arg1.cur_cycle != arg2 || arg1.cur_cycle_points == 0) {
            return 0
        };
        if (!0x2::linked_table::contains<u64, CycleInfo>(&arg0.cycle_info, arg2)) {
            return 0
        };
        let v0 = 0x2::linked_table::borrow<u64, CycleInfo>(&arg0.cycle_info, arg2);
        if (v0.total_points == 0) {
            return 0
        };
        (0xc9a6f26e30f389cb6e436096295a39956f0f4a28d47067c0ab812869030896e1::math::mul_div_u128((arg1.cur_cycle_points as u128), (v0.honey_rewards as u128), (v0.total_points as u128)) as u64)
    }

    public fun query_user_nft_trading_state(arg0: &HoneyJar) : (u64, u64, u64) {
        (arg0.cur_cycle, arg0.cur_cycle_points, arg0.claimable_trading_rewards)
    }

    public fun query_user_pending_activity_rewards(arg0: &MarketplaceChef, arg1: &HoneyJar) : u64 {
        if (arg1.active_points == 0 || arg0.active_points == 0) {
            return 0
        };
        let v0 = arg0.global_claim_index - arg1.claim_index;
        if (v0 == 0) {
            return 0
        };
        (0xc9a6f26e30f389cb6e436096295a39956f0f4a28d47067c0ab812869030896e1::math::mul_div_u256((arg1.active_points as u256), v0, 1000000000000) as u64)
    }

    public fun query_user_total_claimable(arg0: &HoneyJar) : u64 {
        arg0.claimable_rewards + arg0.claimable_trading_rewards + 0x2::balance::value<0x80cc29f3e85da6016b12538f05bacaa05f83d269530b97200be840f63e40ae87::honey::HONEY>(&arg0.claimable_amm_rewards)
    }

    public fun remove_from_honeyjar(arg0: &HoneyJarPointsCap, arg1: &0x2::clock::Clock, arg2: &mut MarketplaceChef, arg3: &mut 0x53cef6da10d7dda4baa6adad5441c9680d2a91f3a3a42fe7ea3db7005045eed0::honey_manager::HoneyManager, arg4: &mut HoneyJar, arg5: u64) {
        validation_check(arg2);
        box_validation_check(arg4);
        increment_honeyjar_rewards(arg1, arg3, arg2, arg4);
        arg2.active_points = arg2.active_points - arg5;
        arg4.active_points = arg4.active_points - arg5;
        let v0 = HoneyJarPointsRemoved{
            honeyjar_id      : 0x2::object::uid_to_address(&arg4.id),
            owner            : arg4.owner,
            points_removed   : arg5,
            box_total_points : arg4.active_points,
        };
        0x2::event::emit<HoneyJarPointsRemoved>(v0);
    }

    public fun update_box_version(arg0: &mut HoneyJar) {
        assert!(arg0.version < 0, 4007);
        arg0.version = 0;
    }

    public fun update_mint_fee(arg0: &HoneyJarAdminCap, arg1: &mut MarketplaceChef, arg2: u64) {
        validation_check(arg1);
        arg1.mint_fee = arg2;
    }

    public fun update_module_version(arg0: &mut MarketplaceChef) {
        assert!(arg0.version < 0, 4007);
        arg0.version = 0;
    }

    public fun validation_check(arg0: &mut MarketplaceChef) {
        assert!(arg0.version == 0, 4007);
    }

    // decompiled from Move bytecode v6
}

