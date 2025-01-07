module 0x6da57ea1ba23da65f6af7d9df2dae45febeb1c69e77d64117112f182f43ddaf8::blap {
    struct BLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAP>(arg0, 6, b"BLAP", b"Blap On Sui", b"BLAP is a hybrid character formed from the combination of the four members of the Boys Club: Brett, Pepe, Andy, and Landwolf.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241127_233400_e8c44f62bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

