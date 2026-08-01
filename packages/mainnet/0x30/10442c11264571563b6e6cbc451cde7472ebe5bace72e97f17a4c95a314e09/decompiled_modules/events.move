module 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events {
    struct OwnerSlotSettlement has copy, drop {
        source_id: 0x2::object::ID,
        lower_bits: u32,
        upper_bits: u32,
        principal_a: u64,
        principal_b: u64,
        fee_a: u64,
        fee_b: u64,
        closing_fee_a: u64,
        closing_fee_b: u64,
        reward_amounts: vector<u64>,
    }

    struct SlotSettlement has copy, drop {
        source_id: 0x2::object::ID,
        source_lower_bits: u32,
        source_upper_bits: u32,
        principal_a: u64,
        principal_b: u64,
        fee_a: u64,
        fee_b: u64,
        closing_fee_a: u64,
        closing_fee_b: u64,
        reward_types: vector<0x1::type_name::TypeName>,
        reward_amounts: vector<u64>,
    }

    struct BelowDestination has copy, drop {
        destination_id: 0x2::object::ID,
        bins: vector<u32>,
        amounts_a: vector<u64>,
        amounts_b: vector<u64>,
        deployed_b: u64,
    }

    struct AboveDestination has copy, drop {
        destination_id: 0x2::object::ID,
        bins: vector<u32>,
        amounts_a: vector<u64>,
        amounts_b: vector<u64>,
        deployed_a: u64,
    }

    struct SwapSettlement has copy, drop {
        direction: u8,
        min_output: u64,
        max_output: u64,
        max_input: u64,
        actual_output: u64,
        actual_input: u64,
        pre_active_bits: u32,
        post_active_bits: u32,
    }

    struct InventoryRebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        sequence: u64,
        generation: u64,
        policy_version: u64,
        settlement: SwapSettlement,
        idle_a: u64,
        idle_b: u64,
        cumulative_swap_input_a: u128,
        cumulative_swap_input_b: u128,
        cumulative_swap_output_a: u128,
        cumulative_swap_output_b: u128,
    }

    struct SettlementCumulative has copy, drop {
        cumulative_principal_a: u128,
        cumulative_principal_b: u128,
        cumulative_fee_a: u128,
        cumulative_fee_b: u128,
        cumulative_closing_fee_a: u128,
        cumulative_closing_fee_b: u128,
    }

    struct RolloverCumulative has copy, drop {
        cumulative_deployed_a: u128,
        cumulative_deployed_b: u128,
        cumulative_principal_a: u128,
        cumulative_principal_b: u128,
        cumulative_fee_a: u128,
        cumulative_fee_b: u128,
        cumulative_closing_fee_a: u128,
        cumulative_closing_fee_b: u128,
        cumulative_swap_input_a: u128,
        cumulative_swap_input_b: u128,
        cumulative_swap_output_a: u128,
        cumulative_swap_output_b: u128,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        versioned_id: 0x2::object::ID,
        owner: address,
        agent: address,
        funding: address,
        cap_id: 0x2::object::ID,
        protocol_version: u64,
        bin_step: u16,
        sequence: u64,
        generation: u64,
        policy_version: u64,
    }

    struct AgentRotated has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        old_agent: address,
        new_agent: address,
        generation: u64,
        cap_id: 0x2::object::ID,
        sequence: u64,
        policy_version: u64,
    }

    struct PolicyUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        version: u64,
        phase: u8,
        paused: bool,
        sequence: u64,
        generation: u64,
    }

    struct FundingDeposit has copy, drop {
        vault_id: 0x2::object::ID,
        funding: address,
        side: u8,
        amount: u64,
        idle_a: u64,
        idle_b: u64,
        funding_sequence: u64,
        action_sequence: u64,
        generation: u64,
        policy_version: u64,
        cumulative_funded_a: u128,
        cumulative_funded_b: u128,
    }

    struct OwnerWithdrawal has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        side: u8,
        amount: u64,
        idle_a: u64,
        idle_b: u64,
        sequence: u64,
        generation: u64,
        policy_version: u64,
    }

    struct RewardRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        sequence: u64,
        generation: u64,
        policy_version: u64,
    }

    struct RewardClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        cumulative_amount: u128,
        sequence: u64,
        generation: u64,
        policy_version: u64,
    }

    struct SlotFeeCollected has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        slot: u8,
        position_id: 0x2::object::ID,
        sequence: u64,
        fee_a: u64,
        fee_b: u64,
        cumulative_fee_a: u128,
        cumulative_fee_b: u128,
        generation: u64,
        policy_version: u64,
    }

    struct SlotRewardCollected has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        slot: u8,
        position_id: 0x2::object::ID,
        sequence: u64,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        cumulative_amount: u128,
        generation: u64,
        policy_version: u64,
    }

    struct OwnerDualOpened has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        below_destination_id: 0x2::object::ID,
        above_destination_id: 0x2::object::ID,
        below_bin_ids: vector<u32>,
        below_amounts_a: vector<u64>,
        below_amounts_b: vector<u64>,
        above_bin_ids: vector<u32>,
        above_amounts_a: vector<u64>,
        above_amounts_b: vector<u64>,
        below_deployed_b: u64,
        above_deployed_a: u64,
        idle_a: u64,
        idle_b: u64,
        sequence: u64,
        generation: u64,
        policy_version: u64,
        cumulative_deployed_a: u128,
        cumulative_deployed_b: u128,
    }

    struct OwnerDualClosed has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        below: OwnerSlotSettlement,
        above: OwnerSlotSettlement,
        reward_types: vector<0x1::type_name::TypeName>,
        idle_a: u64,
        idle_b: u64,
        sequence: u64,
        generation: u64,
        policy_version: u64,
        cumulative: SettlementCumulative,
    }

    struct DualRolloverSettled has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        below: SlotSettlement,
        below_destination: BelowDestination,
        above: SlotSettlement,
        above_destination: AboveDestination,
        idle_a: u64,
        idle_b: u64,
        sequence: u64,
        generation: u64,
        policy_version: u64,
        planned_active_bits: u32,
        observed_active_bits: u32,
        timestamp_ms: u64,
        swap: SwapSettlement,
        cumulative: RolloverCumulative,
    }

    struct DualExitSettled has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        below: SlotSettlement,
        above: SlotSettlement,
        idle_a: u64,
        idle_b: u64,
        sequence: u64,
        generation: u64,
        policy_version: u64,
        planned_active_bits: u32,
        observed_active_bits: u32,
        timestamp_ms: u64,
        cumulative: SettlementCumulative,
    }

    struct CapitalActionSettled has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        resized_existing_pair: bool,
        below_source_id: 0x2::object::ID,
        above_source_id: 0x2::object::ID,
        below_destination_id: 0x2::object::ID,
        above_destination_id: 0x2::object::ID,
        funding_sequence: u64,
        sequence: u64,
        generation: u64,
        policy_version: u64,
        planned_active_bits: u32,
        observed_active_bits: u32,
        timestamp_ms: u64,
        deployed_a: u64,
        deployed_b: u64,
        idle_a: u64,
        idle_b: u64,
        swap_direction: u8,
        actual_swap_output: u64,
        actual_swap_input: u64,
    }

    struct EmergencyRecovered has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        owner: address,
        recipient: address,
        below_position_id: 0x1::option::Option<0x2::object::ID>,
        above_position_id: 0x1::option::Option<0x2::object::ID>,
        amount_a: u64,
        amount_b: u64,
        sequence: u64,
        generation: u64,
        policy_version: u64,
    }

    public(friend) fun emit_agent_rotated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64) {
        let v0 = AgentRotated{
            vault_id       : arg0,
            pool_id        : arg1,
            old_agent      : arg2,
            new_agent      : arg3,
            generation     : arg4,
            cap_id         : arg5,
            sequence       : arg6,
            policy_version : arg7,
        };
        0x2::event::emit<AgentRotated>(v0);
    }

    public(friend) fun emit_capital_action_settled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u8, arg19: u64, arg20: u64) {
        let v0 = CapitalActionSettled{
            vault_id              : arg0,
            pool_id               : arg1,
            resized_existing_pair : arg2,
            below_source_id       : arg3,
            above_source_id       : arg4,
            below_destination_id  : arg5,
            above_destination_id  : arg6,
            funding_sequence      : arg7,
            sequence              : arg8,
            generation            : arg9,
            policy_version        : arg10,
            planned_active_bits   : arg11,
            observed_active_bits  : arg12,
            timestamp_ms          : arg13,
            deployed_a            : arg14,
            deployed_b            : arg15,
            idle_a                : arg16,
            idle_b                : arg17,
            swap_direction        : arg18,
            actual_swap_output    : arg19,
            actual_swap_input     : arg20,
        };
        0x2::event::emit<CapitalActionSettled>(v0);
    }

    public(friend) fun emit_dual_exit_settled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u32, arg5: u32, arg6: u32, arg7: u32, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: vector<0x1::type_name::TypeName>, arg21: vector<u64>, arg22: vector<0x1::type_name::TypeName>, arg23: vector<u64>, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u32, arg30: u32, arg31: u64, arg32: u128, arg33: u128, arg34: u128, arg35: u128, arg36: u128, arg37: u128) {
        let v0 = SlotSettlement{
            source_id         : arg2,
            source_lower_bits : arg4,
            source_upper_bits : arg5,
            principal_a       : arg8,
            principal_b       : arg9,
            fee_a             : arg12,
            fee_b             : arg13,
            closing_fee_a     : arg16,
            closing_fee_b     : arg17,
            reward_types      : arg20,
            reward_amounts    : arg21,
        };
        let v1 = SlotSettlement{
            source_id         : arg3,
            source_lower_bits : arg6,
            source_upper_bits : arg7,
            principal_a       : arg10,
            principal_b       : arg11,
            fee_a             : arg14,
            fee_b             : arg15,
            closing_fee_a     : arg18,
            closing_fee_b     : arg19,
            reward_types      : arg22,
            reward_amounts    : arg23,
        };
        let v2 = SettlementCumulative{
            cumulative_principal_a   : arg32,
            cumulative_principal_b   : arg33,
            cumulative_fee_a         : arg34,
            cumulative_fee_b         : arg35,
            cumulative_closing_fee_a : arg36,
            cumulative_closing_fee_b : arg37,
        };
        let v3 = DualExitSettled{
            vault_id             : arg0,
            pool_id              : arg1,
            below                : v0,
            above                : v1,
            idle_a               : arg24,
            idle_b               : arg25,
            sequence             : arg26,
            generation           : arg27,
            policy_version       : arg28,
            planned_active_bits  : arg29,
            observed_active_bits : arg30,
            timestamp_ms         : arg31,
            cumulative           : v2,
        };
        0x2::event::emit<DualExitSettled>(v3);
    }

    public(friend) fun emit_dual_rollover_settled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: vector<u32>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u32>, arg14: vector<u64>, arg15: vector<u64>, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: vector<0x1::type_name::TypeName>, arg31: vector<u64>, arg32: vector<0x1::type_name::TypeName>, arg33: vector<u64>, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: u64, arg39: u32, arg40: u32, arg41: u64, arg42: u8, arg43: u64, arg44: u64, arg45: u64, arg46: u64, arg47: u64, arg48: u32, arg49: u32, arg50: u128, arg51: u128, arg52: u128, arg53: u128, arg54: u128, arg55: u128, arg56: u128, arg57: u128, arg58: u128, arg59: u128, arg60: u128, arg61: u128) {
        let v0 = SlotSettlement{
            source_id         : arg2,
            source_lower_bits : arg6,
            source_upper_bits : arg7,
            principal_a       : arg18,
            principal_b       : arg19,
            fee_a             : arg22,
            fee_b             : arg23,
            closing_fee_a     : arg26,
            closing_fee_b     : arg27,
            reward_types      : arg30,
            reward_amounts    : arg31,
        };
        let v1 = BelowDestination{
            destination_id : arg3,
            bins           : arg10,
            amounts_a      : arg11,
            amounts_b      : arg12,
            deployed_b     : arg16,
        };
        let v2 = SlotSettlement{
            source_id         : arg4,
            source_lower_bits : arg8,
            source_upper_bits : arg9,
            principal_a       : arg20,
            principal_b       : arg21,
            fee_a             : arg24,
            fee_b             : arg25,
            closing_fee_a     : arg28,
            closing_fee_b     : arg29,
            reward_types      : arg32,
            reward_amounts    : arg33,
        };
        let v3 = AboveDestination{
            destination_id : arg5,
            bins           : arg13,
            amounts_a      : arg14,
            amounts_b      : arg15,
            deployed_a     : arg17,
        };
        let v4 = SwapSettlement{
            direction        : arg42,
            min_output       : arg43,
            max_output       : arg44,
            max_input        : arg45,
            actual_output    : arg46,
            actual_input     : arg47,
            pre_active_bits  : arg48,
            post_active_bits : arg49,
        };
        let v5 = RolloverCumulative{
            cumulative_deployed_a    : arg50,
            cumulative_deployed_b    : arg51,
            cumulative_principal_a   : arg52,
            cumulative_principal_b   : arg53,
            cumulative_fee_a         : arg54,
            cumulative_fee_b         : arg55,
            cumulative_closing_fee_a : arg56,
            cumulative_closing_fee_b : arg57,
            cumulative_swap_input_a  : arg58,
            cumulative_swap_input_b  : arg59,
            cumulative_swap_output_a : arg60,
            cumulative_swap_output_b : arg61,
        };
        let v6 = DualRolloverSettled{
            vault_id             : arg0,
            pool_id              : arg1,
            below                : v0,
            below_destination    : v1,
            above                : v2,
            above_destination    : v3,
            idle_a               : arg34,
            idle_b               : arg35,
            sequence             : arg36,
            generation           : arg37,
            policy_version       : arg38,
            planned_active_bits  : arg39,
            observed_active_bits : arg40,
            timestamp_ms         : arg41,
            swap                 : v4,
            cumulative           : v5,
        };
        0x2::event::emit<DualRolloverSettled>(v6);
    }

    public(friend) fun emit_emergency_recovered(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = EmergencyRecovered{
            vault_id          : arg0,
            pool_id           : arg1,
            owner             : arg2,
            recipient         : arg3,
            below_position_id : arg4,
            above_position_id : arg5,
            amount_a          : arg6,
            amount_b          : arg7,
            sequence          : arg8,
            generation        : arg9,
            policy_version    : arg10,
        };
        0x2::event::emit<EmergencyRecovered>(v0);
    }

    public(friend) fun emit_funding_deposit(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u128) {
        let v0 = FundingDeposit{
            vault_id            : arg0,
            funding             : arg1,
            side                : arg2,
            amount              : arg3,
            idle_a              : arg4,
            idle_b              : arg5,
            funding_sequence    : arg6,
            action_sequence     : arg7,
            generation          : arg8,
            policy_version      : arg9,
            cumulative_funded_a : arg10,
            cumulative_funded_b : arg11,
        };
        0x2::event::emit<FundingDeposit>(v0);
    }

    public(friend) fun emit_inventory_rebalanced(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: u128, arg16: u128, arg17: u128, arg18: u128) {
        let v0 = SwapSettlement{
            direction        : arg5,
            min_output       : arg6,
            max_output       : arg7,
            max_input        : arg8,
            actual_output    : arg9,
            actual_input     : arg10,
            pre_active_bits  : arg11,
            post_active_bits : arg12,
        };
        let v1 = InventoryRebalanced{
            vault_id                 : arg0,
            pool_id                  : arg1,
            sequence                 : arg2,
            generation               : arg3,
            policy_version           : arg4,
            settlement               : v0,
            idle_a                   : arg13,
            idle_b                   : arg14,
            cumulative_swap_input_a  : arg15,
            cumulative_swap_input_b  : arg16,
            cumulative_swap_output_a : arg17,
            cumulative_swap_output_b : arg18,
        };
        0x2::event::emit<InventoryRebalanced>(v1);
    }

    public(friend) fun emit_owner_dual_closed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u32, arg5: u32, arg6: u32, arg7: u32, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: vector<0x1::type_name::TypeName>, arg21: vector<u64>, arg22: vector<u64>, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u128, arg29: u128, arg30: u128, arg31: u128, arg32: u128, arg33: u128) {
        let v0 = OwnerSlotSettlement{
            source_id      : arg2,
            lower_bits     : arg4,
            upper_bits     : arg5,
            principal_a    : arg8,
            principal_b    : arg9,
            fee_a          : arg12,
            fee_b          : arg13,
            closing_fee_a  : arg16,
            closing_fee_b  : arg17,
            reward_amounts : arg21,
        };
        let v1 = OwnerSlotSettlement{
            source_id      : arg3,
            lower_bits     : arg6,
            upper_bits     : arg7,
            principal_a    : arg10,
            principal_b    : arg11,
            fee_a          : arg14,
            fee_b          : arg15,
            closing_fee_a  : arg18,
            closing_fee_b  : arg19,
            reward_amounts : arg22,
        };
        let v2 = SettlementCumulative{
            cumulative_principal_a   : arg28,
            cumulative_principal_b   : arg29,
            cumulative_fee_a         : arg30,
            cumulative_fee_b         : arg31,
            cumulative_closing_fee_a : arg32,
            cumulative_closing_fee_b : arg33,
        };
        let v3 = OwnerDualClosed{
            vault_id       : arg0,
            pool_id        : arg1,
            below          : v0,
            above          : v1,
            reward_types   : arg20,
            idle_a         : arg23,
            idle_b         : arg24,
            sequence       : arg25,
            generation     : arg26,
            policy_version : arg27,
            cumulative     : v2,
        };
        0x2::event::emit<OwnerDualClosed>(v3);
    }

    public(friend) fun emit_owner_dual_opened(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u32>, arg8: vector<u64>, arg9: vector<u64>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u128, arg18: u128) {
        let v0 = OwnerDualOpened{
            vault_id              : arg0,
            pool_id               : arg1,
            below_destination_id  : arg2,
            above_destination_id  : arg3,
            below_bin_ids         : arg4,
            below_amounts_a       : arg5,
            below_amounts_b       : arg6,
            above_bin_ids         : arg7,
            above_amounts_a       : arg8,
            above_amounts_b       : arg9,
            below_deployed_b      : arg10,
            above_deployed_a      : arg11,
            idle_a                : arg12,
            idle_b                : arg13,
            sequence              : arg14,
            generation            : arg15,
            policy_version        : arg16,
            cumulative_deployed_a : arg17,
            cumulative_deployed_b : arg18,
        };
        0x2::event::emit<OwnerDualOpened>(v0);
    }

    public(friend) fun emit_owner_withdrawal(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = OwnerWithdrawal{
            vault_id       : arg0,
            recipient      : arg1,
            side           : arg2,
            amount         : arg3,
            idle_a         : arg4,
            idle_b         : arg5,
            sequence       : arg6,
            generation     : arg7,
            policy_version : arg8,
        };
        0x2::event::emit<OwnerWithdrawal>(v0);
    }

    public(friend) fun emit_policy_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: bool, arg4: u64, arg5: u64) {
        let v0 = PolicyUpdated{
            vault_id   : arg0,
            version    : arg1,
            phase      : arg2,
            paused     : arg3,
            sequence   : arg4,
            generation : arg5,
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public(friend) fun emit_reward_claimed(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = RewardClaimed{
            vault_id          : arg0,
            recipient         : arg1,
            reward_type       : arg2,
            amount            : arg3,
            cumulative_amount : arg4,
            sequence          : arg5,
            generation        : arg6,
            policy_version    : arg7,
        };
        0x2::event::emit<RewardClaimed>(v0);
    }

    public(friend) fun emit_reward_registered(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RewardRegistered{
            vault_id       : arg0,
            reward_type    : arg1,
            sequence       : arg2,
            generation     : arg3,
            policy_version : arg4,
        };
        0x2::event::emit<RewardRegistered>(v0);
    }

    public(friend) fun emit_slot_fee_collected(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u64, arg10: u64) {
        let v0 = SlotFeeCollected{
            vault_id         : arg0,
            pool_id          : arg1,
            slot             : arg2,
            position_id      : arg3,
            sequence         : arg4,
            fee_a            : arg5,
            fee_b            : arg6,
            cumulative_fee_a : arg7,
            cumulative_fee_b : arg8,
            generation       : arg9,
            policy_version   : arg10,
        };
        0x2::event::emit<SlotFeeCollected>(v0);
    }

    public(friend) fun emit_slot_reward_collected(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: u64, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u128, arg8: u64, arg9: u64) {
        let v0 = SlotRewardCollected{
            vault_id          : arg0,
            pool_id           : arg1,
            slot              : arg2,
            position_id       : arg3,
            sequence          : arg4,
            reward_type       : arg5,
            amount            : arg6,
            cumulative_amount : arg7,
            generation        : arg8,
            policy_version    : arg9,
        };
        0x2::event::emit<SlotRewardCollected>(v0);
    }

    public(friend) fun emit_vault_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: address, arg6: address, arg7: 0x2::object::ID, arg8: u64, arg9: u16, arg10: u64, arg11: u64, arg12: u64) {
        let v0 = VaultCreated{
            vault_id         : arg0,
            pool_id          : arg1,
            config_id        : arg2,
            versioned_id     : arg3,
            owner            : arg4,
            agent            : arg5,
            funding          : arg6,
            cap_id           : arg7,
            protocol_version : arg8,
            bin_step         : arg9,
            sequence         : arg10,
            generation       : arg11,
            policy_version   : arg12,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    // decompiled from Move bytecode v7
}

