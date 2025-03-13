module 0x2eb640540fa4a965f7fd477ca6e410b2a85faf2c7829c7df7b21a432991b6826::crla {
    struct CRLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRLA>(arg0, 6, b"CRLA", b"CRCLASSISANT", b"Cyril Ramaphosas cute little assistants scattered around the world. Support him! Our shared great leader.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_198_03f4555b5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

