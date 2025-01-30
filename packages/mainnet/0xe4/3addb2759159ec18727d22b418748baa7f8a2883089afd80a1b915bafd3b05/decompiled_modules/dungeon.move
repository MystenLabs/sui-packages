module 0xe43addb2759159ec18727d22b418748baa7f8a2883089afd80a1b915bafd3b05::dungeon {
    struct DUNGEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUNGEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUNGEON>(arg0, 6, b"DUNGEON", b"Dungeon Cash", b"Dungeon just a meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031168_b43d1916c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUNGEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUNGEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

