module 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::state {
    public fun apply<T0>(arg0: &0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>, arg1: &mut 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::assert_live<T0>(arg0);
        assert!(0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::class<T0>(arg1) == 0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>>(arg0), 401);
        let v0 = 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::voucher::state_message(0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(arg1), 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::rev<T0>(arg1), arg2, arg3, arg4, arg5);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::voucher::verify(0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::issuer_ref<T0>(arg0), &v0, &arg6, arg5, arg7);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::write<T0>(arg1, arg2, arg3);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events::item_updated(0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(arg1), 0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>>(arg0), 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::bump_rev<T0>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

