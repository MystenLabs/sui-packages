module 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_fees {
    struct FeeConfig has store {
        fee_recipient: address,
        performance_fee_bps: u64,
        management_fee_bps: u64,
        last_fee_collection_ms: u64,
        last_total_assets: u128,
    }

    public(friend) fun accrue_fees<T0>(arg0: &mut FeeConfig, arg1: u128, arg2: u64, arg3: u64, arg4: &mut 0x2::coin::TreasuryCap<T0>, arg5: &mut 0x2::tx_context::TxContext) : (u64, u128, u128, u128, u128, u128) {
        if (arg0.management_fee_bps == 0 && arg0.performance_fee_bps == 0) {
            return (0, 0, 0, arg0.last_total_assets, 0, 0)
        };
        if (arg0.last_fee_collection_ms == 0) {
            arg0.last_fee_collection_ms = arg3;
            arg0.last_total_assets = arg1;
            return (0, 0, 0, arg0.last_total_assets, 0, 0)
        };
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        if (arg0.management_fee_bps > 0) {
            let v6 = 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::math::mul_div_down(0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::math::mul_div_down(arg1, (arg0.management_fee_bps as u128), (10000 as u128)), ((arg3 - arg0.last_fee_collection_ms) as u128), 31536000000);
            v4 = v6;
            if (v6 > 0 && arg2 > 0) {
                let v7 = 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::math::mul_div_down(v6, (arg2 as u128), arg1);
                v2 = v7;
                v1 = v0 + v7;
            };
        };
        if (arg0.performance_fee_bps > 0 && arg0.last_total_assets > 0) {
            if (arg1 > arg0.last_total_assets) {
                let v8 = 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::math::mul_div_down(arg1 - arg0.last_total_assets, (arg0.performance_fee_bps as u128), (10000 as u128));
                v5 = v8;
                if (v8 > 0 && arg2 > 0) {
                    let v9 = 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::math::mul_div_down(v8, (arg2 as u128), arg1);
                    v3 = v9;
                    v1 = v1 + v9;
                };
            };
        };
        let v10 = if (v1 > 0) {
            let v11 = 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::math::to_u64(v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(arg4, v11, arg5), arg0.fee_recipient);
            v11
        } else {
            0
        };
        arg0.last_fee_collection_ms = arg3;
        arg0.last_total_assets = arg1;
        (v10, v2, v3, arg0.last_total_assets, v4, v5)
    }

    public(friend) fun apply_management_fee(arg0: &mut FeeConfig, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 500, 1);
        arg0.management_fee_bps = arg1;
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_events::emit_apply_management_fee(arg2, arg1, arg3);
    }

    public(friend) fun apply_performance_fee(arg0: &mut FeeConfig, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 5000, 1);
        arg0.performance_fee_bps = arg1;
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_events::emit_apply_performance_fee(arg2, arg1, arg3);
    }

    public fun get_fee_config(arg0: &FeeConfig) : (address, u64, u64) {
        (arg0.fee_recipient, arg0.performance_fee_bps, arg0.management_fee_bps)
    }

    public fun get_fee_recipient(arg0: &FeeConfig) : address {
        arg0.fee_recipient
    }

    public fun get_last_fee_collection_ms(arg0: &FeeConfig) : u64 {
        arg0.last_fee_collection_ms
    }

    public fun get_last_total_assets(arg0: &FeeConfig) : u128 {
        arg0.last_total_assets
    }

    public fun get_management_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.management_fee_bps
    }

    public fun get_performance_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.performance_fee_bps
    }

    public fun new(arg0: address) : FeeConfig {
        FeeConfig{
            fee_recipient          : arg0,
            performance_fee_bps    : 0,
            management_fee_bps     : 0,
            last_fee_collection_ms : 0,
            last_total_assets      : 0,
        }
    }

    public(friend) fun set_fee_recipient(arg0: &mut FeeConfig, arg1: &0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_governance::Governance, arg2: address, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_governance::ensure_owner(arg1, 0x2::tx_context::sender(arg4));
        assert!(arg2 != arg0.fee_recipient, 2);
        arg0.fee_recipient = arg2;
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_events::emit_set_fee_recipient(arg3, arg0.fee_recipient, arg2, arg4);
    }

    public(friend) fun submit_management_fee(arg0: &FeeConfig, arg1: &mut 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_governance::Governance, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg5));
        assert!(arg2 <= 500, 1);
        let v0 = arg3 + 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_governance::get_timelock_ms(arg1);
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_governance::submit_pending_management_fee(arg1, arg2, v0);
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_events::emit_submit_management_fee(arg4, arg2, v0, 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_events::event_type_submit(), arg5);
    }

    public(friend) fun submit_performance_fee(arg0: &FeeConfig, arg1: &mut 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_governance::Governance, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg5));
        assert!(arg2 <= 5000, 1);
        let v0 = arg3 + 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_governance::get_timelock_ms(arg1);
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_governance::submit_pending_performance_fee(arg1, arg2, v0);
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_events::emit_submit_performance_fee(arg4, arg2, v0, 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_events::event_type_submit(), arg5);
    }

    public(friend) fun update_last_total_assets(arg0: &mut FeeConfig, arg1: u128) {
        arg0.last_total_assets = arg1;
    }

    // decompiled from Move bytecode v6
}

