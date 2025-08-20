module 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::pair_parameter_helper {
    struct PairParameters has copy, drop, store {
        base_factor: u32,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u64,
        max_volatility_accumulator: u32,
        volatility_accumulator: u32,
        volatility_reference: u32,
        id_reference: u32,
        time_of_last_update: u64,
        oracle_id: u16,
        active_id: u32,
    }

    public fun get_active_id(arg0: &PairParameters) : u32 {
        arg0.active_id
    }

    public fun get_base_factor(arg0: &PairParameters) : u32 {
        arg0.base_factor
    }

    public fun get_base_fee(arg0: &PairParameters, arg1: u16) : u64 {
        0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u64(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u64((arg0.base_factor as u64), (arg1 as u64)), 10)
    }

    public fun get_decay_period(arg0: &PairParameters) : u16 {
        arg0.decay_period
    }

    public fun get_delta_id(arg0: &PairParameters, arg1: u32) : u32 {
        let v0 = arg0.active_id;
        if (arg1 > v0) {
            arg1 - v0
        } else {
            v0 - arg1
        }
    }

    public fun get_filter_period(arg0: &PairParameters) : u16 {
        arg0.filter_period
    }

    public fun get_id_reference(arg0: &PairParameters) : u32 {
        arg0.id_reference
    }

    public fun get_max_volatility_accumulator(arg0: &PairParameters) : u32 {
        arg0.max_volatility_accumulator
    }

    public fun get_oracle_id(arg0: &PairParameters) : u16 {
        arg0.oracle_id
    }

    public fun get_protocol_share(arg0: &PairParameters) : u64 {
        arg0.protocol_share
    }

    public fun get_reduction_factor(arg0: &PairParameters) : u16 {
        arg0.reduction_factor
    }

    public fun get_time_of_last_update(arg0: &PairParameters) : u64 {
        arg0.time_of_last_update
    }

    public fun get_total_fee_rate(arg0: &PairParameters, arg1: u16) : u64 {
        0x1::u64::min(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u64(get_base_fee(arg0, arg1), get_variable_fee(arg0, arg1)), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::constants::max_fee_rate())
    }

    public fun get_variable_fee(arg0: &PairParameters, arg1: u16) : u64 {
        let v0 = (arg0.variable_fee_control as u64);
        if (v0 != 0) {
            let v2 = 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u64((arg0.volatility_accumulator as u64), (arg1 as u64));
            (0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u64(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u64(v2, v2), v0) + 99) / 100
        } else {
            0
        }
    }

    public fun get_variable_fee_control(arg0: &PairParameters) : u32 {
        arg0.variable_fee_control
    }

    public fun get_volatility_accumulator(arg0: &PairParameters) : u32 {
        arg0.volatility_accumulator
    }

    public fun get_volatility_reference(arg0: &PairParameters) : u32 {
        arg0.volatility_reference
    }

    public fun new(arg0: u32) : PairParameters {
        PairParameters{
            base_factor                : 0,
            filter_period              : 0,
            decay_period               : 0,
            reduction_factor           : 0,
            variable_fee_control       : 0,
            protocol_share             : 0,
            max_volatility_accumulator : 0,
            volatility_accumulator     : 0,
            volatility_reference       : 0,
            id_reference               : arg0,
            time_of_last_update        : 0,
            oracle_id                  : 0,
            active_id                  : arg0,
        }
    }

    public fun set_active_id(arg0: &mut PairParameters, arg1: u32) {
        arg0.active_id = arg1;
    }

    public fun set_oracle_id(arg0: &mut PairParameters, arg1: u16) {
        arg0.oracle_id = arg1;
    }

    public(friend) fun set_static_fee_parameters(arg0: &mut PairParameters, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32) {
        let v0 = if (arg2 <= arg3) {
            if ((arg4 as u64) <= 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::constants::basis_point_max()) {
                if (arg5 <= 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::constants::max_variable_fee_control()) {
                    arg7 <= 1048575
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 600);
        0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::fee_helper::verify_protocol_share(arg6);
        arg0.base_factor = arg1;
        arg0.filter_period = arg2;
        arg0.decay_period = arg3;
        arg0.reduction_factor = arg4;
        arg0.variable_fee_control = arg5;
        arg0.protocol_share = (arg6 as u64);
        arg0.max_volatility_accumulator = arg7;
    }

    public fun set_volatility_accumulator(arg0: &mut PairParameters, arg1: u32) {
        assert!(arg1 <= 1048575, 600);
        arg0.volatility_accumulator = arg1;
    }

    public fun set_volatility_reference(arg0: &mut PairParameters, arg1: u32) {
        assert!(arg1 <= 1048575, 600);
        arg0.volatility_reference = arg1;
    }

    public fun update_id_reference(arg0: &mut PairParameters) {
        arg0.id_reference = arg0.active_id;
    }

    public fun update_references(arg0: &mut PairParameters, arg1: u64) {
        let v0 = arg1 - arg0.time_of_last_update;
        if (v0 >= (arg0.filter_period as u64)) {
            update_id_reference(arg0);
            if (v0 < (arg0.decay_period as u64)) {
                update_volatility_reference(arg0);
            } else {
                set_volatility_reference(arg0, 0);
            };
        };
        update_time_of_last_update(arg0, arg1);
    }

    public fun update_time_of_last_update(arg0: &mut PairParameters, arg1: u64) {
        arg0.time_of_last_update = arg1;
    }

    public fun update_volatility_accumulator(arg0: &mut PairParameters, arg1: u32) {
        arg0.volatility_accumulator = 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::u64_to_u32(0x1::u64::min(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u64((arg0.volatility_reference as u64), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u64((0x1::u32::diff(arg1, arg0.id_reference) as u64), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::constants::basis_point_max())), (arg0.max_volatility_accumulator as u64)));
    }

    public fun update_volatility_parameters(arg0: &mut PairParameters, arg1: u32, arg2: u64) {
        update_volatility_accumulator(arg0, arg1);
        update_references(arg0, arg2);
    }

    public fun update_volatility_reference(arg0: &mut PairParameters) {
        arg0.volatility_reference = 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::u64_to_u32(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_div_u64((arg0.volatility_accumulator as u64), (arg0.reduction_factor as u64), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::constants::basis_point_max()));
    }

    // decompiled from Move bytecode v6
}

