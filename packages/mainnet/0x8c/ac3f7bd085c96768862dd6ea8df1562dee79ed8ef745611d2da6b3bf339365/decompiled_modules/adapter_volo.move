module 0x8cac3f7bd085c96768862dd6ea8df1562dee79ed8ef745611d2da6b3bf339365::adapter_volo {
    public fun calculate_volo_price(arg0: u256, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) : u256 {
        0x8cac3f7bd085c96768862dd6ea8df1562dee79ed8ef745611d2da6b3bf339365::utils::wad_mul(arg0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::get_ratio(arg1, arg2))
    }

    public fun try_get_volo_ratio(arg0: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) : u256 {
        0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::get_ratio(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

