module 0xba55e02958957afdbe3560c45eea3470b04a5c17ada0f2a8270a7b22c795acff::vovo {
    struct VoVo has copy, drop, store {
        sui: u64,
        vsui: u64,
    }

    public entry fun sui_to_vsui(arg0: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: u64) {
        let v0 = VoVo{
            sui  : arg2,
            vsui : 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::to_shares(arg0, arg1, arg2),
        };
        0x2::event::emit<VoVo>(v0);
    }

    // decompiled from Move bytecode v6
}

