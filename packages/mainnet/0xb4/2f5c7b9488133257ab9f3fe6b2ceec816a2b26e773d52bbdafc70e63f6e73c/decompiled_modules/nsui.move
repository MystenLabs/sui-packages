module 0xb42f5c7b9488133257ab9f3fe6b2ceec816a2b26e773d52bbdafc70e63f6e73c::nsui {
    struct NSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSUI>(arg0, 6, b"nSUI", b"First nigga on sui", b"Im, you, he, she, him, her NIG***", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul139_20241011131055_b0125a102d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

