module 0xc3213e769e222f573edb14c63bf11b6481f3d3b66f2206f5911be07032390883::dvn_fee_lib {
    struct DVN_FEE_LIB has drop {
        dummy_field: bool,
    }

    struct DvnFeeLib has key {
        id: 0x2::object::UID,
        call_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
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
        let v2 = arg3 * (0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::get_native_decimals_rate() as u128) / arg4 + arg0;
        if (v2 > v1) {
            v2
        } else {
            v1
        }
    }

    public fun confirm_get_fee(arg0: &DvnFeeLib, arg1: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64>, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::EstimateFeeParam, 0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::EstimateFeeResult>) {
        let (_, _, v2) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy_child<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64, 0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::EstimateFeeParam, 0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::EstimateFeeResult>(arg1, &arg0.call_cap, arg2);
        let v3 = v2;
        let v4 = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(arg1);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(arg1, &arg0.call_cap, (apply_premium(0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::fee(&v3), 0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::multiplier_bps(v4), 0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::default_multiplier_bps(v4), 0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::floor_margin_usd(v4), 0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::native_price_usd(&v3)) as u64));
    }

    fun get_call_data_size(arg0: u64) : u64 {
        let v0 = arg0 * 65;
        let v1 = v0;
        if (v0 % 32 != 0) {
            v1 = v0 - v0 % 32 + 32;
        };
        260 + 288 + v1 + 32
    }

    public fun get_fee(arg0: &DvnFeeLib, arg1: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::EstimateFeeParam, 0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::EstimateFeeResult> {
        let v0 = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(arg1);
        assert!(0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::gas(v0) != 0, 1);
        assert!(0x1::vector::is_empty<u8>(0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::options(v0)), 2);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create_single_child<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64, 0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::EstimateFeeParam, 0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::EstimateFeeResult>(arg1, &arg0.call_cap, 0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::price_feed(v0), 0x54c68690697e311f0d4b76bc488bb00b156a961ee0ad40a4bf9b13ad97135886::estimate_fee::create_param(0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::dst_eid(v0), get_call_data_size(0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::quorum(v0)), 0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::gas(v0)), arg2)
    }

    fun init(arg0: DVN_FEE_LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DvnFeeLib{
            id       : 0x2::object::new(arg1),
            call_cap : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::new_package_cap<DVN_FEE_LIB>(&arg0, arg1),
        };
        0x2::transfer::share_object<DvnFeeLib>(v0);
    }

    // decompiled from Move bytecode v6
}

