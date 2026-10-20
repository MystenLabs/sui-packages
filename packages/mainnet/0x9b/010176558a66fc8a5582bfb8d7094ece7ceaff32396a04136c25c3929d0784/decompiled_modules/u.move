module 0x9b010176558a66fc8a5582bfb8d7094ece7ceaff32396a04136c25c3929d0784::u {
    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg6);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(arg5, arg6);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        0x2::coin::into_balance<T0>(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::buy<T0>(arg0, arg1, arg2, arg3, &mut v0, 0x2::balance::value<0x2::sui::SUI>(&arg5), 0, 0x1::option::none<address>(), arg4, arg6))
    }

    public fun xs<T0>(arg0: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg6);
        0x2::coin::into_balance<0x2::sui::SUI>(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::sell<T0>(arg0, arg1, arg2, arg3, 0x2::coin::from_balance<T0>(arg5, arg6), 0, 0x1::option::none<address>(), arg4, arg6))
    }

    // decompiled from Move bytecode v7
}

