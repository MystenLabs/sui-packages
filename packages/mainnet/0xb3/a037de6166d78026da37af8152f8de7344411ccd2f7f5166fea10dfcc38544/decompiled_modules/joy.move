module 0xb3a037de6166d78026da37af8152f8de7344411ccd2f7f5166fea10dfcc38544::joy {
    struct JOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JOY>(arg0, 6, b"JOY", b"FACE WITH TEARS OF JOY", b"SuiEmoji Face with Tears of Joy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiemoji.fun/emojis/joy.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

