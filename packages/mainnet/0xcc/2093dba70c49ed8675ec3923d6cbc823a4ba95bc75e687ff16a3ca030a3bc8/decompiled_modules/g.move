module 0xcc2093dba70c49ed8675ec3923d6cbc823a4ba95bc75e687ff16a3ca030a3bc8::g {
    public fun gfdlmm<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: u32, arg2: bool, arg3: u64) {
        let v0 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0);
        assert!(arg2 && v0 >= arg1 || v0 <= arg1, 101);
        if (arg3 > 0 && v0 == arg1) {
            let (v1, v2) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin<T0, T1>(arg0, v0);
            let v3 = if (arg2) {
                v2
            } else {
                v1
            };
            assert!(v3 >= arg3, 101);
        };
    }

    public fun glbm<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: u32, arg2: bool, arg3: u64, arg4: u64) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        assert!(arg2 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, v1) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v0, v1), 101);
        if (arg3 > 0) {
            let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::reserves<T0, T1>(arg0);
            let v4 = if (arg2) {
                v3
            } else {
                v2
            };
            assert!(v4 >= arg3, 101);
        };
        let v5 = if (arg4 > 0) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, v1)) {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v0, v1)
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            let (v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::amounts_in_active_bin<T0, T1>(arg0);
            let v8 = if (arg2) {
                v7
            } else {
                v6
            };
            assert!(v8 >= arg4, 101);
        };
    }

    // decompiled from Move bytecode v7
}

