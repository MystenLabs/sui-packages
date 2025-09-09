module 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox {
    struct GEARBOX has drop {
        dummy_field: bool,
    }

    struct GearBoxAdminCap has store, key {
        id: 0x2::object::UID,
        chef_id: 0x1::option::Option<address>,
    }

    struct GearBoxPointsCap has store, key {
        id: 0x2::object::UID,
    }

    struct GearBoxFeeClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct GearBoxChef has key {
        id: 0x2::object::UID,
        mint_fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        gear_boxes: 0x2::linked_table::LinkedTable<address, address>,
        gearbox_points: 0x2::linked_table::LinkedTable<address, u64>,
        pre_launch_phase: bool,
        last_claim_ts: u64,
        distribution_rate: u256,
        global_claim_index: u256,
        total_distributed: u64,
        active_points: u64,
        bag: 0x2::bag::Bag,
        version: u64,
    }

    struct RewardsHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_balance: 0x2::balance::Balance<T0>,
    }

    struct GearBox has key {
        id: 0x2::object::UID,
        index: u64,
        created_at: u64,
        owner: address,
        referrer: 0x1::option::Option<address>,
        active_points: u64,
        claim_index: u256,
        claimable_rewards: u64,
        total_claimed_rewards: u64,
        bag: 0x2::bag::Bag,
        version: u64,
    }

    struct ClaimProtocolEarnings has copy, drop {
        user: address,
        claimed_rewards: u64,
    }

    struct DistributionRateUpdated has copy, drop {
        distribution_rate: u256,
    }

    struct RewardsHolderInitialized has copy, drop {
        id: address,
    }

    struct PreLaunchCampaignFinished has copy, drop {
        deposit_amount: u64,
        active_points: u64,
        per_point_reward: u256,
    }

    struct RewardsAddedToChef has copy, drop {
        deposit_amount: u64,
        total_available: u64,
    }

    struct GearBoxMinted has copy, drop {
        gear_box_id: address,
        owner: address,
        index: u64,
        referrer: 0x1::option::Option<address>,
        timestamp: u64,
    }

    struct GearBoxPointsAwarded has copy, drop {
        gear_box_id: address,
        owner: address,
        points_earned: u64,
        box_total_points: u64,
    }

    struct GearBoxRewardsClaimed has copy, drop {
        gear_box_id: address,
        owner: address,
        claimed_rewards: u64,
        total_claimed_rewards: u64,
    }

    struct ReferrerSet has copy, drop {
        gear_box_id: address,
        owner: address,
        referrer: address,
    }

    struct GearBoxPointsAwardedOnSale has copy, drop {
        owner: address,
        points_earned: u64,
    }

    public fun add_points_on_sale(arg0: &GearBoxPointsCap, arg1: &mut GearBoxChef, arg2: address, arg3: u64) {
        validation_check(arg1);
        if (!arg1.pre_launch_phase) {
            return
        };
        let v0 = *0x2::linked_table::borrow<address, u64>(&mut arg1.gearbox_points, arg2);
        *0x2::linked_table::borrow_mut<address, u64>(&mut arg1.gearbox_points, arg2) = v0 + arg3;
        arg1.active_points = arg1.active_points + arg3 + v0;
        let v1 = GearBoxPointsAwardedOnSale{
            owner         : arg2,
            points_earned : arg3,
        };
        0x2::event::emit<GearBoxPointsAwardedOnSale>(v1);
    }

    public fun add_rewards_for_distribution<T0>(arg0: &mut GearBoxChef, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        validation_check(arg0);
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"SIMPLAY_REWARDS_HOLDER"), 4006);
        assert!(!arg0.pre_launch_phase, 4011);
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, RewardsHolder<T0>>(&mut arg0.id, b"SIMPLAY_REWARDS_HOLDER");
        0x2::balance::join<T0>(&mut v0.coin_balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = RewardsAddedToChef{
            deposit_amount  : arg2,
            total_available : 0x2::balance::value<T0>(&v0.coin_balance),
        };
        0x2::event::emit<RewardsAddedToChef>(v1);
    }

    public fun add_to_box(arg0: &GearBoxPointsCap, arg1: &0x2::clock::Clock, arg2: &mut GearBoxChef, arg3: &mut GearBox, arg4: u64) {
        validation_check(arg2);
        box_validation_check(arg3);
        if (!arg2.pre_launch_phase) {
            increment_gear_box_rewards(arg1, arg2, arg3);
        };
        let v0 = *0x2::linked_table::borrow<address, u64>(&mut arg2.gearbox_points, arg3.owner);
        *0x2::linked_table::borrow_mut<address, u64>(&mut arg2.gearbox_points, arg3.owner) = 0;
        arg2.active_points = arg2.active_points + arg4 + v0;
        arg3.active_points = arg3.active_points + arg4 + v0;
        let v1 = GearBoxPointsAwarded{
            gear_box_id      : 0x2::object::uid_to_address(&arg3.id),
            owner            : arg3.owner,
            points_earned    : arg4,
            box_total_points : arg3.active_points,
        };
        0x2::event::emit<GearBoxPointsAwarded>(v1);
    }

    public fun box_validation_check(arg0: &mut GearBox) {
        update_box_version(arg0);
    }

    public fun claim_rewards<T0>(arg0: &0x2::clock::Clock, arg1: &mut GearBoxChef, arg2: &mut GearBox, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        box_validation_check(arg2);
        if (arg1.pre_launch_phase) {
            return
        };
        increment_gear_box_rewards(arg0, arg1, arg2);
        if (arg2.claimable_rewards > 0) {
            let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, RewardsHolder<T0>>(&mut arg1.id, b"SIMPLAY_REWARDS_HOLDER");
            assert!(0x2::balance::value<T0>(&v0.coin_balance) >= arg2.claimable_rewards, 4001);
            0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<T0>(0x2::balance::split<T0>(&mut v0.coin_balance, arg2.claimable_rewards), 0x2::tx_context::sender(arg3), arg3);
            arg2.total_claimed_rewards = arg2.total_claimed_rewards + arg2.claimable_rewards;
            arg2.claimable_rewards = 0;
            let v1 = GearBoxRewardsClaimed{
                gear_box_id           : 0x2::object::uid_to_address(&arg2.id),
                owner                 : arg2.owner,
                claimed_rewards       : arg2.claimable_rewards,
                total_claimed_rewards : arg2.total_claimed_rewards,
            };
            0x2::event::emit<GearBoxRewardsClaimed>(v1);
        };
    }

    public fun claim_sui_collected(arg0: &GearBoxFeeClaimCap, arg1: &mut GearBoxChef, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let v0 = ClaimProtocolEarnings{
            user            : arg2,
            claimed_rewards : 0x2::balance::value<0x2::sui::SUI>(&arg1.balance),
        };
        0x2::event::emit<ClaimProtocolEarnings>(v0);
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2, arg3);
    }

    public fun delete_gearbox_points_cap(arg0: GearBoxPointsCap, arg1: &mut 0x2::tx_context::TxContext) {
        let GearBoxPointsCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun finish_prelaunch_campaign<T0>(arg0: &GearBoxAdminCap, arg1: &0x2::clock::Clock, arg2: &mut GearBoxChef, arg3: 0x2::coin::Coin<T0>, arg4: u64) {
        validation_check(arg2);
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&arg2.id, b"SIMPLAY_REWARDS_HOLDER"), 4006);
        assert!(arg2.pre_launch_phase, 4011);
        arg2.pre_launch_phase = false;
        arg2.last_claim_ts = 0x2::clock::timestamp_ms(arg1);
        arg2.global_claim_index = 0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::mul_div_u256((arg4 as u256), (1000000000000000000 as u256), (arg2.active_points as u256));
        arg2.total_distributed = arg4;
        0x2::balance::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<vector<u8>, RewardsHolder<T0>>(&mut arg2.id, b"SIMPLAY_REWARDS_HOLDER").coin_balance, 0x2::coin::into_balance<T0>(arg3));
        let v0 = PreLaunchCampaignFinished{
            deposit_amount   : arg4,
            active_points    : arg2.active_points,
            per_point_reward : arg2.global_claim_index,
        };
        0x2::event::emit<PreLaunchCampaignFinished>(v0);
    }

    public fun get_referrer(arg0: &GearBox) : 0x1::option::Option<address> {
        arg0.referrer
    }

    public fun has_referrer(arg0: &GearBox) : bool {
        0x1::option::is_some<address>(&arg0.referrer)
    }

    fun increment_gear_box_rewards(arg0: &0x2::clock::Clock, arg1: &mut GearBoxChef, arg2: &mut GearBox) {
        increment_global_index(arg0, arg1);
        arg2.claimable_rewards = arg2.claimable_rewards + (0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::mul_div_u256(arg1.global_claim_index - arg2.claim_index, (arg2.active_points as u256), (1000000000000000000 as u256)) as u64);
        arg2.claim_index = arg1.global_claim_index;
    }

    fun increment_global_index(arg0: &0x2::clock::Clock, arg1: &mut GearBoxChef) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 <= arg1.last_claim_ts) {
            return
        };
        let v1 = (0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::mul_div_u256(((v0 - arg1.last_claim_ts) as u256), (arg1.distribution_rate as u256), (1000000000000000000 as u256)) as u64);
        arg1.global_claim_index = arg1.global_claim_index + 0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::mul_div_u256((v1 as u256), (1000000000000000000 as u256), (arg1.active_points as u256));
        arg1.last_claim_ts = v0;
        arg1.total_distributed = arg1.total_distributed + v1;
    }

    fun init(arg0: GEARBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"website"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"claimable_points"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"referrer"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"total_points"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"GEARBOX BOX #{index}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A points system that rewards participation, engagement, and value-driven actions on DreamFlow's marketplace."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.simplay.ai/static/gearBox.webp"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://simplay.ai"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claimable Points: {chest_points}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Referrer: {referrer}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Total Points: {total_points}"));
        let v4 = 0x2::package::claim<GEARBOX>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GearBox>(&v4, v0, v2, arg1);
        0x2::display::update_version<GearBox>(&mut v5);
        let v6 = GearBoxAdminCap{
            id      : 0x2::object::new(arg1),
            chef_id : 0x1::option::none<address>(),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GearBox>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<GearBoxAdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun init_chest_chef(arg0: &mut GearBoxAdminCap, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<address>(&arg0.chef_id), 4000);
        let v0 = GearBoxChef{
            id                 : 0x2::object::new(arg3),
            mint_fee           : arg2,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            gear_boxes         : 0x2::linked_table::new<address, address>(arg3),
            gearbox_points     : 0x2::linked_table::new<address, u64>(arg3),
            pre_launch_phase   : true,
            last_claim_ts      : 0x2::clock::timestamp_ms(arg1),
            distribution_rate  : 0,
            global_claim_index : 0,
            total_distributed  : 0,
            active_points      : 0,
            bag                : 0x2::bag::new(arg3),
            version            : 0,
        };
        arg0.chef_id = 0x1::option::some<address>(0x2::object::uid_to_address(&v0.id));
        0x2::transfer::share_object<GearBoxChef>(v0);
    }

    public fun init_rewards_holder<T0>(arg0: &GearBoxAdminCap, arg1: &mut GearBoxChef, arg2: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        assert!(!0x2::dynamic_object_field::exists_<vector<u8>>(&arg1.id, b"SIMPLAY_REWARDS_HOLDER"), 4010);
        let v0 = RewardsHolder<T0>{
            id           : 0x2::object::new(arg2),
            coin_balance : 0x2::balance::zero<T0>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, RewardsHolder<T0>>(&mut arg1.id, b"SIMPLAY_REWARDS_HOLDER", v0);
        let v1 = RewardsHolderInitialized{id: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<RewardsHolderInitialized>(v1);
    }

    public fun is_pre_launch_phase(arg0: &GearBoxChef) : bool {
        arg0.pre_launch_phase
    }

    public fun mint_gear_box(arg0: &0x2::clock::Clock, arg1: &mut GearBoxChef, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::linked_table::contains<address, address>(&arg1.gear_boxes, v0), 4009);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.mint_fee, 4012);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, arg1.mint_fee));
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg4), arg4);
        let v2 = if (0x1::option::is_some<address>(&arg3)) {
            assert!(*0x1::option::borrow<address>(&arg3) != v0, 4008);
            arg3
        } else {
            0x1::option::none<address>()
        };
        let v3 = GearBox{
            id                    : 0x2::object::new(arg4),
            index                 : 0x2::linked_table::length<address, address>(&arg1.gear_boxes),
            created_at            : 0x2::clock::timestamp_ms(arg0),
            owner                 : v0,
            referrer              : v2,
            active_points         : 0,
            claim_index           : arg1.global_claim_index,
            claimable_rewards     : 0,
            total_claimed_rewards : 0,
            bag                   : 0x2::bag::new(arg4),
            version               : 0,
        };
        0x2::linked_table::push_back<address, address>(&mut arg1.gear_boxes, v0, 0x2::object::uid_to_address(&v3.id));
        0x2::linked_table::push_back<address, u64>(&mut arg1.gearbox_points, v0, 0);
        let v4 = GearBoxMinted{
            gear_box_id : 0x2::object::uid_to_address(&v3.id),
            owner       : v0,
            index       : v3.index,
            referrer    : v3.referrer,
            timestamp   : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<GearBoxMinted>(v4);
        0x2::transfer::transfer<GearBox>(v3, v0);
    }

    public fun mint_gearbox_points_cap(arg0: &GearBoxAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GearBoxPointsCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<GearBoxPointsCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun set_referrer(arg0: &mut GearBox, arg1: address) {
        assert!(0x1::option::is_none<address>(&arg0.referrer), 4013);
        arg0.referrer = 0x1::option::some<address>(arg1);
        let v0 = ReferrerSet{
            gear_box_id : 0x2::object::uid_to_address(&arg0.id),
            owner       : arg0.owner,
            referrer    : arg1,
        };
        0x2::event::emit<ReferrerSet>(v0);
    }

    public fun update_box_version(arg0: &mut GearBox) {
        assert!(arg0.version < 0, 4007);
        arg0.version = 0;
    }

    public fun update_distribution_rate(arg0: &mut GearBoxChef, arg1: &0x2::clock::Clock, arg2: u256) {
        validation_check(arg0);
        increment_global_index(arg1, arg0);
        arg0.distribution_rate = arg2;
        let v0 = DistributionRateUpdated{distribution_rate: arg2};
        0x2::event::emit<DistributionRateUpdated>(v0);
    }

    public fun update_module_version(arg0: &mut GearBoxChef) {
        assert!(arg0.version < 0, 4007);
        arg0.version = 0;
    }

    public fun validation_check(arg0: &mut GearBoxChef) {
        assert!(arg0.version == 0, 4007);
    }

    // decompiled from Move bytecode v6
}

