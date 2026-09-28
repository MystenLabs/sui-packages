module 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::holder_launch {
    public fun initialize<T0>(arg0: &0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u8, arg12: u64, arg13: address, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::holder_rewards::create<T0>(arg13, arg14, arg15);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::object::id_address<0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::holder_rewards::Vault<T0>>(&v0));
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, arg14);
        if (arg14 < 10000) {
            0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg15));
            0x1::vector::push_back<u64>(&mut v2, 10000 - arg14);
        };
        0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::initialize_curve_with_rewards<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v1, v2, arg15);
        0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::holder_rewards::share<T0>(v0);
    }

    // decompiled from Move bytecode v7
}

