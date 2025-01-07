module 0xd5c3e690170bd9fdcc35331d5a4f232953bab4783eb61e99ac9cc67904c19a90::rabbyt {
    struct RABBYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBYT>(arg0, 6, b"RABBYT", b"RABBYT BABY", b"little cute bbyt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_8_eb8e71a97f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABBYT>>(v1);
    }

    // decompiled from Move bytecode v6
}

