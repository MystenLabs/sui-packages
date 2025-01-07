module 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm {
    struct Farm<phantom T0> has store, key {
        id: 0x2::object::UID,
        rewards_farm: 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::Farm<T0>,
        points_info: PointsInfo,
    }

    struct PointsInfo has store {
        total_accumulated_points: u64,
        total_claimed_points: u64,
        index: u128,
        updated_at: u64,
        start_time: u64,
    }

    struct StakeReceiptWithPoints has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        rewards_stake_receipt: 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::StakeReceipt,
        user_points_info: UserPointsInfo,
    }

    struct UserPointsInfo has store {
        updated_at: u64,
        claimed_points: u64,
        index: u128,
    }

    public(friend) fun claim_reward<T0, T1>(arg0: &mut Farm<T0>, arg1: &mut StakeReceiptWithPoints, arg2: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert_farm_id<T0>(arg0, arg1);
        harvest_points_for_user<T0>(arg0, arg1, arg3);
        0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::claim::claim_reward<T0, T1>(&mut arg0.rewards_farm, &mut arg1.rewards_stake_receipt, arg2, arg3, arg4)
    }

    public(friend) fun stake<T0>(arg0: &mut Farm<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg4: &mut 0x2::tx_context::TxContext) : StakeReceiptWithPoints {
        let v0 = UserPointsInfo{
            updated_at     : 0x2::clock::timestamp_ms(arg2) / 1000,
            claimed_points : 0,
            index          : arg0.points_info.index,
        };
        StakeReceiptWithPoints{
            id                    : 0x2::object::new(arg4),
            farm_id               : 0x2::object::id<Farm<T0>>(arg0),
            rewards_stake_receipt : 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::stake::stake<T0>(&mut arg0.rewards_farm, arg1, arg2, arg3, arg4),
            user_points_info      : v0,
        }
    }

    public(friend) fun increase_stake<T0>(arg0: &mut Farm<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut StakeReceiptWithPoints, arg3: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_farm_id<T0>(arg0, arg2);
        harvest_points_for_user<T0>(arg0, arg2, arg4);
        0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::stake::increase_stake<T0>(&mut arg0.rewards_farm, &mut arg2.rewards_stake_receipt, arg1, arg3, arg4, arg5);
    }

    public(friend) fun unstake<T0>(arg0: &mut Farm<T0>, arg1: &mut StakeReceiptWithPoints, arg2: u64, arg3: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_farm_id<T0>(arg0, arg1);
        harvest_points_for_user<T0>(arg0, arg1, arg4);
        0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::unstake::unstake<T0>(&mut arg0.rewards_farm, &mut arg1.rewards_stake_receipt, arg2, arg3, arg4, arg5)
    }

    fun assert_farm_id<T0>(arg0: &Farm<T0>, arg1: &StakeReceiptWithPoints) {
        assert!(arg1.farm_id == 0x2::object::id<Farm<T0>>(arg0), 0);
    }

    public(friend) fun harvest_points_for_user<T0>(arg0: &mut Farm<T0>, arg1: &mut StakeReceiptWithPoints, arg2: &0x2::clock::Clock) {
        assert_farm_id<T0>(arg0, arg1);
        if (arg1.user_points_info.index >= arg0.points_info.index) {
            return
        };
        let v0 = (0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::utils::mul_factor_u128((0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::user_shares(&arg1.rewards_stake_receipt) as u128), arg0.points_info.index - arg1.user_points_info.index, 18446744073709551616) as u64);
        arg0.points_info.total_claimed_points = arg0.points_info.total_claimed_points + v0;
        arg1.user_points_info.claimed_points = arg1.user_points_info.claimed_points + v0;
        arg1.user_points_info.updated_at = 0x2::clock::timestamp_ms(arg2) / 1000;
    }

    public(friend) fun initialize<T0>(arg0: 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::Farm<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Farm<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = PointsInfo{
            total_accumulated_points : 0,
            total_claimed_points     : 0,
            index                    : 0,
            updated_at               : v0,
            start_time               : v0,
        };
        Farm<T0>{
            id           : 0x2::object::new(arg2),
            rewards_farm : arg0,
            points_info  : v1,
        }
    }

    public fun points_info<T0>(arg0: &Farm<T0>) : (u64, u64, u128) {
        (arg0.points_info.total_accumulated_points, arg0.points_info.total_claimed_points, arg0.points_info.index)
    }

    public fun receipt_points_info(arg0: &StakeReceiptWithPoints) : u64 {
        arg0.user_points_info.claimed_points
    }

    public fun rewards_farm<T0>(arg0: &Farm<T0>) : &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::Farm<T0> {
        &arg0.rewards_farm
    }

    public(friend) fun rewards_farm_mut<T0>(arg0: &mut Farm<T0>) : &mut 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::Farm<T0> {
        &mut arg0.rewards_farm
    }

    public fun rewards_stake_receipt(arg0: &StakeReceiptWithPoints) : &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::StakeReceipt {
        &arg0.rewards_stake_receipt
    }

    public fun simulate_current_points<T0>(arg0: &Farm<T0>, arg1: &StakeReceiptWithPoints) : u64 {
        assert_farm_id<T0>(arg0, arg1);
        if (arg1.user_points_info.index >= arg0.points_info.index) {
            return arg0.points_info.total_claimed_points
        };
        arg0.points_info.total_claimed_points + (0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::utils::mul_factor_u128((0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::user_shares(&arg1.rewards_stake_receipt) as u128), arg0.points_info.index - arg1.user_points_info.index, 18446744073709551616) as u64)
    }

    public(friend) fun update_points<T0>(arg0: &mut Farm<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        arg0.points_info.index = arg0.points_info.index + 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::utils::mul_factor_u128(((arg1 - arg0.points_info.total_accumulated_points) as u128), 18446744073709551616, (0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::total_staked<T0>(&arg0.rewards_farm) as u128));
        arg0.points_info.total_accumulated_points = arg1;
        arg0.points_info.updated_at = 0x2::clock::timestamp_ms(arg2) / 1000;
    }

    // decompiled from Move bytecode v6
}

