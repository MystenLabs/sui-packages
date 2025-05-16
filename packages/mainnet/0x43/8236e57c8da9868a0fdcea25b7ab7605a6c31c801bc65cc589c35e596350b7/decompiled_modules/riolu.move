module 0x438236e57c8da9868a0fdcea25b7ab7605a6c31c801bc65cc589c35e596350b7::riolu {
    struct RIOLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIOLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIOLU>(arg0, 6, b"RIOLU", b"Riolu Pokemon Battle", b"Riolu builds pokemon battle game on @SuiNetwork  .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie65zj32qdm4yxu4fqv6nvrg5cpv2evfbhtkuzey2ewynmhdw3g7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIOLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIOLU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

