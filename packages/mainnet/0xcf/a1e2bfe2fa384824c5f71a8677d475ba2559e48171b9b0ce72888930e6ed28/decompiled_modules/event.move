module 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event {
    struct PixelListEvent has copy, drop {
        creator: address,
        index: u64,
        token_name: 0x1::string::String,
        token_symbol: 0x1::ascii::String,
        token_type: 0x1::string::String,
        token_description: 0x1::string::String,
        image_url: 0x1::option::Option<0x2::url::Url>,
        token_balance: u64,
        sui_balance: u64,
        token_reserve: u64,
        buy_fee_rate: u64,
        sell_fee_rate: u64,
        stake_fee_rate: u64,
        fee: u64,
        target_supply_threshold: u64,
        virtual_sui_amount: u64,
    }

    struct SwapEvent has copy, drop {
        is_buy: bool,
        sender: address,
        token_name: 0x1::string::String,
        token_symbol: 0x1::ascii::String,
        token_type: 0x1::string::String,
        amount_in: u64,
        amount_out: u64,
        swap_fee_rate: u64,
        stake_fee_rate: u64,
        swap_fee: u64,
        stake_fee: u64,
    }

    struct MigratePendingEvent has copy, drop {
        token_name: 0x1::string::String,
        token_symbol: 0x1::ascii::String,
        token_type: 0x1::string::String,
        sui_reserve_amount: u64,
        token_reserve_amount: u64,
    }

    struct StakeEvent has copy, drop {
        index: u64,
        token_name: 0x1::string::String,
        token_symbol: 0x1::ascii::String,
        token_type: 0x1::string::String,
        stake_adddress: address,
        stake_amount: u64,
    }

    struct UnstakeEvent has copy, drop {
        index: u64,
        token_name: 0x1::string::String,
        token_symbol: 0x1::ascii::String,
        token_type: 0x1::string::String,
        unstake_adddress: address,
        unstake_amount: u64,
    }

    struct ClaimStakeRewards has copy, drop {
        index: u64,
        token_name: 0x1::string::String,
        token_symbol: 0x1::ascii::String,
        token_type: 0x1::string::String,
        sender: address,
        rewards: u64,
    }

    struct NewLeaderEvent has copy, drop {
        index: u64,
        token_name: 0x1::string::String,
        token_symbol: 0x1::ascii::String,
        token_type: 0x1::string::String,
        leader_address: 0x1::option::Option<address>,
        leader_stake_amount: u64,
    }

    struct JoinAllianceEvent has copy, drop {
        sender: address,
        source_index: u64,
        source_pixel_name: 0x1::string::String,
        source_pixel_symbol: 0x1::ascii::String,
        source_pixel_type: 0x1::string::String,
        target_index: u64,
        target_pixel_name: 0x1::string::String,
        target_pixel_symbol: 0x1::ascii::String,
        target_pixel_type: 0x1::string::String,
        join_fee: u64,
    }

    struct LeaveAllianceEvent has copy, drop {
        sender: address,
        source_index: u64,
        source_pixel_name: 0x1::string::String,
        source_pixel_symbol: 0x1::ascii::String,
        source_pixel_type: 0x1::string::String,
        target_index: u64,
        target_pixel_name: 0x1::string::String,
        target_pixel_symbol: 0x1::ascii::String,
        target_pixel_type: 0x1::string::String,
    }

    struct DestroyPixelEvent has copy, drop {
        win_pixel_type: 0x1::string::String,
        win_pixel_name: 0x1::string::String,
        win_pixel_symbol: 0x1::ascii::String,
        destroy_pixel_type: 0x1::string::String,
        destroy_pixel_name: 0x1::string::String,
        destroy_pixel_symbol: 0x1::ascii::String,
        lucky_pixel_type: 0x1::string::String,
        lucky_pixel_name: 0x1::string::String,
        lucy_pixel_symbol: 0x1::ascii::String,
        destroy_amount: u64,
        win_amount: u64,
        lucky_amount: u64,
        sender: address,
    }

    struct DecoratePixelEvent has copy, drop {
        sender: address,
        pixel_type: 0x1::string::String,
        pixel_name: 0x1::string::String,
        pixel_symbol: 0x1::ascii::String,
        image_url: 0x2::url::Url,
        fee: u64,
    }

    public fun claim_stake_rewards_event(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: address, arg5: u64) {
        let v0 = ClaimStakeRewards{
            index        : arg0,
            token_name   : arg1,
            token_symbol : arg2,
            token_type   : arg3,
            sender       : arg4,
            rewards      : arg5,
        };
        0x2::event::emit<ClaimStakeRewards>(v0);
    }

    public fun decorate_pixel_event(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x2::url::Url, arg5: u64) {
        let v0 = DecoratePixelEvent{
            sender       : arg0,
            pixel_type   : arg1,
            pixel_name   : arg2,
            pixel_symbol : arg3,
            image_url    : arg4,
            fee          : arg5,
        };
        0x2::event::emit<DecoratePixelEvent>(v0);
    }

    public fun destroy_pixel_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::ascii::String, arg9: u64, arg10: u64, arg11: u64, arg12: address) {
        let v0 = DestroyPixelEvent{
            win_pixel_type       : arg0,
            win_pixel_name       : arg1,
            win_pixel_symbol     : arg2,
            destroy_pixel_type   : arg3,
            destroy_pixel_name   : arg4,
            destroy_pixel_symbol : arg5,
            lucky_pixel_type     : arg6,
            lucky_pixel_name     : arg7,
            lucy_pixel_symbol    : arg8,
            destroy_amount       : arg9,
            win_amount           : arg10,
            lucky_amount         : arg11,
            sender               : arg12,
        };
        0x2::event::emit<DestroyPixelEvent>(v0);
    }

    public fun join_alliance_event(arg0: address, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::ascii::String, arg8: 0x1::string::String, arg9: u64) {
        let v0 = JoinAllianceEvent{
            sender              : arg0,
            source_index        : arg1,
            source_pixel_name   : arg2,
            source_pixel_symbol : arg3,
            source_pixel_type   : arg4,
            target_index        : arg5,
            target_pixel_name   : arg6,
            target_pixel_symbol : arg7,
            target_pixel_type   : arg8,
            join_fee            : arg9,
        };
        0x2::event::emit<JoinAllianceEvent>(v0);
    }

    public fun leave_alliance_event(arg0: address, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::ascii::String, arg8: 0x1::string::String) {
        let v0 = LeaveAllianceEvent{
            sender              : arg0,
            source_index        : arg1,
            source_pixel_name   : arg2,
            source_pixel_symbol : arg3,
            source_pixel_type   : arg4,
            target_index        : arg5,
            target_pixel_name   : arg6,
            target_pixel_symbol : arg7,
            target_pixel_type   : arg8,
        };
        0x2::event::emit<LeaveAllianceEvent>(v0);
    }

    public fun migrate_pending_event(arg0: 0x1::string::String, arg1: 0x1::ascii::String, arg2: 0x1::string::String, arg3: u64, arg4: u64) {
        let v0 = MigratePendingEvent{
            token_name           : arg0,
            token_symbol         : arg1,
            token_type           : arg2,
            sui_reserve_amount   : arg3,
            token_reserve_amount : arg4,
        };
        0x2::event::emit<MigratePendingEvent>(v0);
    }

    public fun new_leader_event(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<address>, arg5: u64) {
        let v0 = NewLeaderEvent{
            index               : arg0,
            token_name          : arg1,
            token_symbol        : arg2,
            token_type          : arg3,
            leader_address      : arg4,
            leader_stake_amount : arg5,
        };
        0x2::event::emit<NewLeaderEvent>(v0);
    }

    public fun pixel_list_event(arg0: address, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x2::url::Url>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64) {
        let v0 = PixelListEvent{
            creator                 : arg0,
            index                   : arg1,
            token_name              : arg2,
            token_symbol            : arg3,
            token_type              : arg4,
            token_description       : arg5,
            image_url               : arg6,
            token_balance           : arg7,
            sui_balance             : arg8,
            token_reserve           : arg9,
            buy_fee_rate            : arg10,
            sell_fee_rate           : arg11,
            stake_fee_rate          : arg12,
            fee                     : arg13,
            target_supply_threshold : arg14,
            virtual_sui_amount      : arg15,
        };
        0x2::event::emit<PixelListEvent>(v0);
    }

    public fun stake_event(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: address, arg5: u64) {
        let v0 = StakeEvent{
            index          : arg0,
            token_name     : arg1,
            token_symbol   : arg2,
            token_type     : arg3,
            stake_adddress : arg4,
            stake_amount   : arg5,
        };
        0x2::event::emit<StakeEvent>(v0);
    }

    public fun swap_event(arg0: bool, arg1: address, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = SwapEvent{
            is_buy         : arg0,
            sender         : arg1,
            token_name     : arg2,
            token_symbol   : arg3,
            token_type     : arg4,
            amount_in      : arg5,
            amount_out     : arg6,
            swap_fee_rate  : arg7,
            stake_fee_rate : arg8,
            swap_fee       : arg9,
            stake_fee      : arg10,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public fun unstake_event(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: address, arg5: u64) {
        let v0 = UnstakeEvent{
            index            : arg0,
            token_name       : arg1,
            token_symbol     : arg2,
            token_type       : arg3,
            unstake_adddress : arg4,
            unstake_amount   : arg5,
        };
        0x2::event::emit<UnstakeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

