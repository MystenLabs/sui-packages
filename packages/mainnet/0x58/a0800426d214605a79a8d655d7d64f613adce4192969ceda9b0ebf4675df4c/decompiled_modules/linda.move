module 0x58a0800426d214605a79a8d655d7d64f613adce4192969ceda9b0ebf4675df4c::linda {
    struct LINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINDA>(arg0, 6, b"LINDA", b"Linda on Sui", x"4920747275737465642065766572797468696e670a4e6f772069206c6f73742065766572797468696e670a536f6d656f6e6520706c6561736520636865636b206f6e206d650a4f6720476f64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig3xajyxzn2finl6h4jkwkiik53p3jzrzp7s5kf2jj2auimdvvl3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LINDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

