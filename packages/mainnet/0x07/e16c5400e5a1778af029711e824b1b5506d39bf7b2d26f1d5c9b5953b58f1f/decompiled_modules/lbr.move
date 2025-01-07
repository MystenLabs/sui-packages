module 0x7e16c5400e5a1778af029711e824b1b5506d39bf7b2d26f1d5c9b5953b58f1f::lbr {
    struct LBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBR>(arg0, 9, b"LBR", b"LIBRA", b"Zodiac is a person's criteria", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fe16ab6-7f9e-4964-b160-e2b8b7a30075.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

