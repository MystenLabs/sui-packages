module 0x4a4309721a65fecf1d8e861132d03c6c5b25b9e05c5cd4b6b2cd68bbe4859a16::hmu {
    public fun f<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x8a2c701c2a3bd9a3f0b746ecd929b15c3816d0b1ef2dadd53dc055a8b4c489a1::holder::hold<T0>(arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

