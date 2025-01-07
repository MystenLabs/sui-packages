module 0x8ae9489d97f19a0adb7f64b8dd99fab21a69c27abd00ab2135b5a155eb12f0d::groggoss {
    struct GROGGOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGGOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGGOSS>(arg0, 6, b"GROGGOSS", b"Groggo Sui", b"Groggo on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9315_469b38706f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGGOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROGGOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

