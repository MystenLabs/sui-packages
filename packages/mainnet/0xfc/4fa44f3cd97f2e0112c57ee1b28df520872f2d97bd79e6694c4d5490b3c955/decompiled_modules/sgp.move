module 0xfc4fa44f3cd97f2e0112c57ee1b28df520872f2d97bd79e6694c4d5490b3c955::sgp {
    struct SGP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGP>(arg0, 6, b"SGP", b"Sui Guard Protection", b"SGP - Security of digital assets on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007976_ad9c531d77.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGP>>(v1);
    }

    // decompiled from Move bytecode v6
}

