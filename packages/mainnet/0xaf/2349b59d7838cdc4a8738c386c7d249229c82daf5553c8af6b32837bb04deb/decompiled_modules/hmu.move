module 0xaf2349b59d7838cdc4a8738c386c7d249229c82daf5553c8af6b32837bb04deb::hmu {
    public fun f<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x8a2c701c2a3bd9a3f0b746ecd929b15c3816d0b1ef2dadd53dc055a8b4c489a1::holder::hold<T0>(arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

