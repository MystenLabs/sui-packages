module 0xd96842e40b605e291e04e0b2e937b2e7f1bf44a6091f8fe70bf1ab32897020ca::basi {
    struct BASI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASI>(arg0, 6, b"BASI", b"BASILISK TOKEN", b"The First AI deployed token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BASI_fb95a0f3be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASI>>(v1);
    }

    // decompiled from Move bytecode v6
}

