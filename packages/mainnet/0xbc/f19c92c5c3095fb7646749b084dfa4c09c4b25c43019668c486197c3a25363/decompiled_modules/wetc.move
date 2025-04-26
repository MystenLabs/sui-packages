module 0xbcf19c92c5c3095fb7646749b084dfa4c09c4b25c43019668c486197c3a25363::wetc {
    struct WETC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETC>(arg0, 6, b"WETC", b"WETCOIN", x"574554434f494e20666f72206c6f6e677465726d200a526561647920746f2070617920444558206f6e636520626f6e6465640a526561647920746f2062757920766f6c756d6520626f6f7374206f6e636520626f6e64656420616e64206c6973746564206f6e2044657873637265656e6572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/waet_9beb35dd63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WETC>>(v1);
    }

    // decompiled from Move bytecode v6
}

