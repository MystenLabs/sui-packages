module 0x4db99de81e326d81f0947e5ec847426b4d4d86ac31390cda35d46746e5c0ef22::schip {
    struct SCHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHIP>(arg0, 6, b"SCHIP", b"SUI CHIP", b"SUI CHIP NEXT BLUECHIP MEME ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4775_56221d14ac.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

