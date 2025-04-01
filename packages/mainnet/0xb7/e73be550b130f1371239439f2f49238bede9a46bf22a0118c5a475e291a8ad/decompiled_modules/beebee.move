module 0xb7e73be550b130f1371239439f2f49238bede9a46bf22a0118c5a475e291a8ad::beebee {
    struct BEEBEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEBEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEBEE>(arg0, 6, b"BEEBEE", b"Beebee", b"The name \"Pepe\" in Arabic Pronounced as Bee-Bee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053027_1d612cc8c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEBEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEBEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

