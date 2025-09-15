module 0x4cdd97cf2dee8387b004915c293d0565577e0194fff4894e604a09db54ac62c7::executor_fee_lib {
    struct EXECUTOR_FEE_LIB has drop {
        dummy_field: bool,
    }

    struct ExecutorFeeLib has key {
        id: 0x2::object::UID,
        call_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
    }

    fun apply_premium_to_gas(arg0: u128, arg1: u16, arg2: u128, arg3: u128) : u128 {
        let v0 = arg0 * (arg1 as u128) / 10000;
        if (arg3 == 0 || arg2 == 0) {
            return v0
        };
        let v1 = arg2 * (0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::get_native_decimals_rate() as u128) / arg3 + arg0;
        if (v1 > v0) {
            v1
        } else {
            v0
        }
    }

    public fun confirm_get_fee(arg0: &ExecutorFeeLib, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::FeelibGetFeeParam, u64>, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeParam, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeResult>) {
        let (_, _, v2) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy_child<0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::FeelibGetFeeParam, u64, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeParam, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeResult>(arg1, &arg0.call_cap, arg2);
        let v3 = v2;
        let v4 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::FeelibGetFeeParam, u64>(arg1);
        let (v5, _) = decode_executor_options(*0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::options(v4), 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::dst_eid(v4), 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::lz_receive_base_gas(v4), 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::lz_compose_base_gas(v4), 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::native_cap(v4));
        let v7 = if (0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::multiplier_bps(v4) == 0) {
            0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::default_multiplier_bps(v4)
        } else {
            0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::multiplier_bps(v4)
        };
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete<0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::FeelibGetFeeParam, u64>(arg1, &arg0.call_cap, ((apply_premium_to_gas(0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::fee(&v3), v7, 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::floor_margin_usd(v4), 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::native_price_usd(&v3)) + convert_and_apply_premium_to_value(v5, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::price_ratio(&v3), 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::price_ratio_denominator(&v3), v7)) as u64));
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
        let v0 = 0x4cdd97cf2dee8387b004915c293d0565577e0194fff4894e604a09db54ac62c7::executor_option::parse_executor_options(arg0, is_v1_eid(arg1), arg4);
        let v1 = if (0x4cdd97cf2dee8387b004915c293d0565577e0194fff4894e604a09db54ac62c7::executor_option::ordered(&v0)) {
            ((arg2 as u128) + 0x4cdd97cf2dee8387b004915c293d0565577e0194fff4894e604a09db54ac62c7::executor_option::total_gas(&v0) + (arg3 as u128) * (0x4cdd97cf2dee8387b004915c293d0565577e0194fff4894e604a09db54ac62c7::executor_option::num_lz_compose(&v0) as u128)) * 102 / 100
        } else {
            (arg2 as u128) + 0x4cdd97cf2dee8387b004915c293d0565577e0194fff4894e604a09db54ac62c7::executor_option::total_gas(&v0) + (arg3 as u128) * (0x4cdd97cf2dee8387b004915c293d0565577e0194fff4894e604a09db54ac62c7::executor_option::num_lz_compose(&v0) as u128)
        };
        (0x4cdd97cf2dee8387b004915c293d0565577e0194fff4894e604a09db54ac62c7::executor_option::total_value(&v0), v1)
    }

    public fun get_fee(arg0: &ExecutorFeeLib, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::FeelibGetFeeParam, u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeParam, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeResult> {
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::FeelibGetFeeParam, u64>(arg1);
        assert!(0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::lz_receive_base_gas(v0) != 0, 1);
        let (_, v2) = decode_executor_options(*0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::options(v0), 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::dst_eid(v0), 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::lz_receive_base_gas(v0), 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::lz_compose_base_gas(v0), 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::native_cap(v0));
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create_single_child<0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::FeelibGetFeeParam, u64, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeParam, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeResult>(arg1, &arg0.call_cap, 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::price_feed(v0), 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::create_param(0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::dst_eid(v0), 0xf571a338c1a18e7c2094ef32dc340633004a3fe657e42e0c811b465294030f32::executor_feelib_get_fee::call_data_size(v0), (v2 as u256)), arg2)
    }

    fun init(arg0: EXECUTOR_FEE_LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutorFeeLib{
            id       : 0x2::object::new(arg1),
            call_cap : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<EXECUTOR_FEE_LIB>(&arg0, arg1),
        };
        0x2::transfer::share_object<ExecutorFeeLib>(v0);
    }

    fun is_v1_eid(arg0: u32) : bool {
        arg0 < 30000
    }

    // decompiled from Move bytecode v6
}

