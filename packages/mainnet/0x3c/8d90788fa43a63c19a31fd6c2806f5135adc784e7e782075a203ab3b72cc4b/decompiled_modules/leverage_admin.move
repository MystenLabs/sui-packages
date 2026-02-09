module 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::AdminCap, arg1: &mut 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_app::LeverageApp, arg2: 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::PackageCallerCap) {
        0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::AdminCap, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_market::LeverageMarket>(0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_market::new_market(0x2::object::id<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::AdminCap, arg1: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg2: &mut 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_app::LeverageApp) {
        0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

