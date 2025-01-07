module 0x25ce9e4a15f9eea4495863864f4718cb181c9512be64e23a7b2ccf13769fbe42::babytoto {
    struct BABYTOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTOTO>(arg0, 6, b"BabyTOTO", b"Baby TOTODILE", b"Baby TOTO is the cutest pet in pokeverse, it gives you joy and fun. Love Lots from Baby TOTODILE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731941779813.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYTOTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTOTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

