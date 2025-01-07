module 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::setup {
    public fun setup<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(@0x79ff1c736a917a2acd1847c41bf1f29ac1cd7e37570a3a35cb2e447248d7121f == 0x2::tx_context::sender(arg9), 9223372139934056450);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::new<T0>(arg0, arg1, arg2, arg3, arg4, to_url(arg5), arg6, arg7, arg8, arg9));
    }

    fun to_url(arg0: vector<u8>) : 0x1::option::Option<0x2::url::Url> {
        if (0x1::vector::is_empty<u8>(&arg0)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

