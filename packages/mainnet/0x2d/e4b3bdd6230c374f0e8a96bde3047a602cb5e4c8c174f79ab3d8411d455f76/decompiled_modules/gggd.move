module 0x2de4b3bdd6230c374f0e8a96bde3047a602cb5e4c8c174f79ab3d8411d455f76::gggd {
    struct GGGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGGD>(arg0, 9, b"GGGA", b"gggd", b"gggawdd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGGD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGGD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

