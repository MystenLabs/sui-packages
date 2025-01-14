module 0xd5a7a8c051caffad3d092b140d42bbf800acacc1ac09ac90cef34dbeb6b99315::illu {
    struct ILLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILLU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ILLU>(arg0, 6, b"ILLU", b"IlluminAI by SuiAI", b"A simple agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/waifu_1_87ae5af38f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ILLU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILLU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

