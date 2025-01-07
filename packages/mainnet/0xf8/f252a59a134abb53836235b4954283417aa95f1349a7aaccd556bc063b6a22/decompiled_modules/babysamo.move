module 0xf8f252a59a134abb53836235b4954283417aa95f1349a7aaccd556bc063b6a22::babysamo {
    struct BABYSAMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSAMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSAMO>(arg0, 6, b"BABYSAMO", b"Baby Samoyed", x"424142592053414d4f59454420546865204d6f73742041646f7261626c6520535549205075707079210a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_c2d7b4321c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSAMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSAMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

