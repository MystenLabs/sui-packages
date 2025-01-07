module 0x74a81d4bcab47f3e4c722f4945971e12bf866cbbb1551240652fda46d9a80450::pcats {
    struct PCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCATS>(arg0, 6, b"PCATS", b"POPCAT ON SUI", b"POP POP POP CAT CAT CAT SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/535837a68e8a8d1bc85c5e3eb7f94b8e_00ea9c8a57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

