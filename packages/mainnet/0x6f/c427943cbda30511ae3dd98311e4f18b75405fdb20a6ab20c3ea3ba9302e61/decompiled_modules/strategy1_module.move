module 0x6fc427943cbda30511ae3dd98311e4f18b75405fdb20a6ab20c3ea3ba9302e61::strategy1_module {
    struct OpenPositionEvent has copy, drop {
        sender: address,
    }

    public fun open_position(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        let v0 = OpenPositionEvent{sender: 0x2::tx_context::sender(arg4)};
        0x2::event::emit<OpenPositionEvent>(v0);
        0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::stake_non_entry(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

