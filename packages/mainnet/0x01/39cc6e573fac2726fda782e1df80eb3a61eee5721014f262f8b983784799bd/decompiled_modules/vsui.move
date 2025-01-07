module 0x139cc6e573fac2726fda782e1df80eb3a61eee5721014f262f8b983784799bd::vsui {
    public fun s_v(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, u64) {
        let v0 = 0x139cc6e573fac2726fda782e1df80eb3a61eee5721014f262f8b983784799bd::help::merge_all<0x2::sui::SUI>(arg3, arg5);
        0x139cc6e573fac2726fda782e1df80eb3a61eee5721014f262f8b983784799bd::help::transfer<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5));
        let v1 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::stake_non_entry(arg0, arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut v0, arg4, arg5), arg5);
        (v1, 0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v1))
    }

    public fun s_v2(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>, u64) {
        let (v0, v1) = s_v(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>();
        0x1::vector::push_back<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

