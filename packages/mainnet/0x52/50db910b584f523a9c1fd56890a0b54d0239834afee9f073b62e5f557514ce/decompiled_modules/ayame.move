module 0x5250db910b584f523a9c1fd56890a0b54d0239834afee9f073b62e5f557514ce::ayame {
    struct AYAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AYAME>(arg0, 6, b"AYAME", b"Ayame AI by SuiAI", b"Simple AI Agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ayame_5da486be79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AYAME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYAME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

