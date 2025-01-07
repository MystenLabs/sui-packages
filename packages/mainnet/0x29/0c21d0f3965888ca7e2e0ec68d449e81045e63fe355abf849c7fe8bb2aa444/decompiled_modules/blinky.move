module 0x290c21d0f3965888ca7e2e0ec68d449e81045e63fe355abf849c7fe8bb2aa444::blinky {
    struct BLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKY>(arg0, 6, b"BLINKY", b"Blinky", b"Blinky the Three-Eyed Fish (or simply Blinky) is a three-eyed orange fish species, found in the ponds and lakes outside the nuclear power plant. The Springfield Nuclear Power Plant caused the mutations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/logo_190d4316fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

