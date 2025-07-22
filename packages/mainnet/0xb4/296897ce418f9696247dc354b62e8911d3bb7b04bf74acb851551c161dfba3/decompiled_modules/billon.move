module 0xb4296897ce418f9696247dc354b62e8911d3bb7b04bf74acb851551c161dfba3::billon {
    struct BILLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLON>(arg0, 6, b"BILLON", b"Billon Coin", b"I'm BILLON, the blue balloon flying, we will meet in the air", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiacc3e6457k3pnkuh2oy3ai7ar6sg6hkb3fikx6wemg7hnqvxtg7e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BILLON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

