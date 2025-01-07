module 0xecade4aa82e924213f6a5d644c34e8134ba1718c27735e6535d3f13e6a5b5290::joy {
    struct JOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JOY>(arg0, 6, b"JOY", b"FACE WITH TEARS OF JOY", b"SuiEmoji Face with Tears of Joy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/joy.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

