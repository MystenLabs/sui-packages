module 0xada88ab63875b32e8a55fb17282a1c83c8e77cc0d6dd51e675063f764b157cb1::teardrop {
    struct TEARDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEARDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEARDROP>(arg0, 6, b"TEARDROP", b"teardrop on sui", b"a teardrop every so often is okay.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/teardrop_logo_b7290ddbd1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEARDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEARDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

