module 0xa2c2b02fed600d4119458f07f9c9fa22eedd38522c426820a275578dc32cd089::faceb {
    struct FACEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACEB>(arg0, 6, b"FACEB", b"TWITCH", b"BOTH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigu3xvvlnfpp5ozs46argwc7chv2spv6pzl3kfsaei25dcf66hku4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FACEB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

