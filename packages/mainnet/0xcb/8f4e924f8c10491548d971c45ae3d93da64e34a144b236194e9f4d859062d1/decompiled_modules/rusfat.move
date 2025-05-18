module 0xcb8f4e924f8c10491548d971c45ae3d93da64e34a144b236194e9f4d859062d1::rusfat {
    struct RUSFAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSFAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSFAT>(arg0, 6, b"RUSFAT", b"TheWalrusFat", b"RUSFAT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihkrt6givs3xweezfg6wduijpoyzjpc3uvtqprvonupitcdfmwc5i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSFAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUSFAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

