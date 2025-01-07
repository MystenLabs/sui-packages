module 0x802ffe922640d96fcd9e323a09f76eda05f1aaeb3e0549acc32ea5473b299e91::benoit {
    struct BENOIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENOIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENOIT>(arg0, 6, b"BENOIT", b"le fils a rug", b"ffff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_4_d13c7e3416.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENOIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENOIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

