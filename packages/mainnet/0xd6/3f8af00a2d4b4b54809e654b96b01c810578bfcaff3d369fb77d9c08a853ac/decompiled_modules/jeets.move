module 0xd63f8af00a2d4b4b54809e654b96b01c810578bfcaff3d369fb77d9c08a853ac::jeets {
    struct JEETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEETS>(arg0, 6, b"JEETS", b"RICO JEETS", b"shut up and buy dont ask why djdjsjsjjsjs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1091_890032f5e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

