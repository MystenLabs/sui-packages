module 0xb94f476ccd37034f4f5fb9c541320b85f86e61ae7f654fa66f3b987e8fb3f825::dvn_fee_lib {
    struct DVN_FEE_LIB has drop {
        dummy_field: bool,
    }

    struct DvnFeeLib has key {
        id: 0x2::object::UID,
        call_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
    }

    fun apply_premium(arg0: u128, arg1: u16, arg2: u16, arg3: u128, arg4: u128) : u128 {
        let v0 = if (arg1 == 0) {
            arg2
        } else {
            arg1
        };
        let v1 = arg0 * (v0 as u128) / 10000;
        if (arg4 == 0 || arg3 == 0) {
            return v1
        };
        let v2 = arg3 * (0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::get_native_decimals_rate() as u128) / arg4 + arg0;
        if (v2 > v1) {
            v2
        } else {
            v1
        }
    }

    public fun confirm_get_fee(arg0: &DvnFeeLib, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64>, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeParam, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeResult>) {
        let (_, _, v2) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy_child<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeParam, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeResult>(arg1, &arg0.call_cap, arg2);
        let v3 = v2;
        let v4 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(arg1);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(arg1, &arg0.call_cap, (apply_premium(0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::fee(&v3), 0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::multiplier_bps(v4), 0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::default_multiplier_bps(v4), 0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::floor_margin_usd(v4), 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::native_price_usd(&v3)) as u64));
    }

    fun get_call_data_size(arg0: u64) : u64 {
        let v0 = arg0 * 65;
        let v1 = v0;
        if (v0 % 32 != 0) {
            v1 = v0 - v0 % 32 + 32;
        };
        260 + 288 + v1 + 32
    }

    public fun get_fee(arg0: &DvnFeeLib, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeParam, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeResult> {
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(arg1);
        assert!(0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::gas(v0) != 0, 1);
        assert!(0x1::vector::is_empty<u8>(0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::options(v0)), 2);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create_single_child<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeParam, 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::EstimateFeeResult>(arg1, &arg0.call_cap, 0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::price_feed(v0), 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee::create_param(0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::dst_eid(v0), get_call_data_size(0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::quorum(v0)), 0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::gas(v0)), arg2)
    }

    fun init(arg0: DVN_FEE_LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DvnFeeLib{
            id       : 0x2::object::new(arg1),
            call_cap : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<DVN_FEE_LIB>(&arg0, arg1),
        };
        0x2::transfer::share_object<DvnFeeLib>(v0);
    }

    // decompiled from Move bytecode v6
}

