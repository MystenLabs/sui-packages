module 0x67d037134fae9d5163461ef2c3d84a07d47f17aa54a222d9546fea272ec8000::lambopepe {
    struct LAMBOPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBOPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBOPEPE>(arg0, 6, b"LAMBOPEPE", b"Lambopepe", b"The most badass car to ever hit SUI! A fcking lambo with Pepe's face on it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6071114076408366130_97aeec6d87.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBOPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMBOPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

