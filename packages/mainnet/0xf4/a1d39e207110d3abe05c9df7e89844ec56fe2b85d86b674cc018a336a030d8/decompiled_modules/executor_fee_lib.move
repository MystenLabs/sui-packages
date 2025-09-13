module 0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_fee_lib {
    struct EXECUTOR_FEE_LIB has drop {
        dummy_field: bool,
    }

    struct ExecutorFeeLib has key {
        id: 0x2::object::UID,
        call_cap: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap,
    }

    fun apply_premium_to_gas(arg0: u128, arg1: u16, arg2: u128, arg3: u128) : u128 {
        let v0 = arg0 * (arg1 as u128) / 10000;
        if (arg3 == 0 || arg2 == 0) {
            return v0
        };
        let v1 = arg2 * (0x51581fb8c0980849c66aadd3914bce68090cf7378683016b6fc51bcdcf6991fe::worker_common::get_native_decimals_rate() as u128) / arg3 + arg0;
        if (v1 > v0) {
            v1
        } else {
            v0
        }
    }

    public fun confirm_get_fee(arg0: &ExecutorFeeLib, arg1: &mut 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::FeelibGetFeeParam, u64>, arg2: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::EstimateFeeParam, 0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::EstimateFeeResult>) {
        let (_, _, v2) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy_child<0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::FeelibGetFeeParam, u64, 0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::EstimateFeeParam, 0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::EstimateFeeResult>(arg1, &arg0.call_cap, arg2);
        let v3 = v2;
        let v4 = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::FeelibGetFeeParam, u64>(arg1);
        let (v5, _) = decode_executor_options(*0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::options(v4), 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::dst_eid(v4), 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::lz_receive_base_gas(v4), 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::lz_compose_base_gas(v4), 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::native_cap(v4));
        let v7 = if (0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::multiplier_bps(v4) == 0) {
            0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::default_multiplier_bps(v4)
        } else {
            0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::multiplier_bps(v4)
        };
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::complete<0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::FeelibGetFeeParam, u64>(arg1, &arg0.call_cap, ((apply_premium_to_gas(0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::fee(&v3), v7, 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::floor_margin_usd(v4), 0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::native_price_usd(&v3)) + convert_and_apply_premium_to_value(v5, 0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::price_ratio(&v3), 0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::price_ratio_denominator(&v3), v7)) as u64));
    }

    fun convert_and_apply_premium_to_value(arg0: u128, arg1: u128, arg2: u128, arg3: u16) : u128 {
        let v0 = if (arg0 > 0) {
            arg0 * arg1 / arg2 * (arg3 as u128) / 10000
        } else {
            0
        };
        (v0 as u128)
    }

    fun decode_executor_options(arg0: vector<u8>, arg1: u32, arg2: u64, arg3: u64, arg4: u128) : (u128, u128) {
        let v0 = 0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_option::parse_executor_options(arg0, is_v1_eid(arg1), arg4);
        let v1 = if (0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_option::ordered(&v0)) {
            ((arg2 as u128) + 0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_option::total_gas(&v0) + (arg3 as u128) * (0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_option::num_lz_compose(&v0) as u128)) * 102 / 100
        } else {
            (arg2 as u128) + 0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_option::total_gas(&v0) + (arg3 as u128) * (0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_option::num_lz_compose(&v0) as u128)
        };
        (0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_option::total_value(&v0), v1)
    }

    public fun get_fee(arg0: &ExecutorFeeLib, arg1: &mut 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::FeelibGetFeeParam, u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::EstimateFeeParam, 0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::EstimateFeeResult> {
        let v0 = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::FeelibGetFeeParam, u64>(arg1);
        assert!(0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::lz_receive_base_gas(v0) != 0, 1);
        let (_, v2) = decode_executor_options(*0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::options(v0), 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::dst_eid(v0), 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::lz_receive_base_gas(v0), 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::lz_compose_base_gas(v0), 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::native_cap(v0));
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::create_single_child<0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::FeelibGetFeeParam, u64, 0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::EstimateFeeParam, 0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::EstimateFeeResult>(arg1, &arg0.call_cap, 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::price_feed(v0), 0xe101210c2a1fa29b13481c845fb4dbd3d8473095412f774d9d4c281aa345491a::estimate_fee::create_param(0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::dst_eid(v0), 0x3b37ff46cc523896c5e2eef7a4286ed4d360dd519d7b6fe143a32c4fdc687a0f::executor_feelib_get_fee::call_data_size(v0), (v2 as u256)), arg2)
    }

    fun init(arg0: EXECUTOR_FEE_LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutorFeeLib{
            id       : 0x2::object::new(arg1),
            call_cap : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<EXECUTOR_FEE_LIB>(&arg0, arg1),
        };
        0x2::transfer::share_object<ExecutorFeeLib>(v0);
    }

    fun is_v1_eid(arg0: u32) : bool {
        arg0 < 30000
    }

    // decompiled from Move bytecode v6
}

