module 0x16d0e70b77a7962847803ce0e76933c94edc2c1ea3a2f972c5f7c59e887f2156::volo {
    struct VoloSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b(arg0: &mut 0x16d0e70b77a7962847803ce0e76933c94edc2c1ea3a2f972c5f7c59e887f2156::config::Config, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        let v0 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::stake_non_entry(arg1, arg2, arg3, arg4, arg5);
        let (v1, v2) = 0x16d0e70b77a7962847803ce0e76933c94edc2c1ea3a2f972c5f7c59e887f2156::config::pay_fee<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, v0, arg5);
        let v3 = VoloSwapEvent{
            amount_in  : 0x2::coin::value<0x2::sui::SUI>(&arg4),
            amount_out : 0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v0) - v2,
            coin_a     : 0x1::type_name::get<0x2::sui::SUI>(),
            coin_b     : 0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(),
        };
        0x2::event::emit<VoloSwapEvent>(v3);
        v1
    }

    // decompiled from Move bytecode v6
}

