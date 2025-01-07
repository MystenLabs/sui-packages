module 0x98aad6fbfa377fdcf31c79d4650ea3cc6b2bbccec5bdb35598632623deecfe89::tuputamadre {
    struct TUPUTAMADRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUPUTAMADRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUPUTAMADRE>(arg0, 6, b"Tuputamadre", b"Pepojn", b"hhjjb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_12_04_00_02_37_46c52f2c8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUPUTAMADRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUPUTAMADRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

