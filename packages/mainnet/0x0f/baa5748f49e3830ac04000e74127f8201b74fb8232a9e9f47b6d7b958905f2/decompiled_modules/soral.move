module 0xfbaa5748f49e3830ac04000e74127f8201b74fb8232a9e9f47b6d7b958905f2::soral {
    struct SORAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORAL>(arg0, 6, b"SORAL", b"SoralInu", b"FAUT LE SAVOIR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/soral_ccd3b67265.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

