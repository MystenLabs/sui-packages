module 0xee8fcc3b136cd45f01086dba60bc12f15e7a5dab7f1bd09f1357b147a5f65b7a::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAME>(arg0, 9, b"Game", b"w", b"11111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a849c3daf625c5427a9d9d564ae96bbcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

