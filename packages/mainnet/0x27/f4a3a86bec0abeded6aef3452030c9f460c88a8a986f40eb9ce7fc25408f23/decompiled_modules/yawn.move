module 0x27f4a3a86bec0abeded6aef3452030c9f460c88a8a986f40eb9ce7fc25408f23::yawn {
    struct YAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWN>(arg0, 6, b"YAWN", b"YAWN On Sui", b"First YAWN On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yawn_social_gif_3303f86e9b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

