module 0xf79a06e63247b666a98fff47de62fea034ae8111d3bfccbdf376ef0567301e12::popa {
    struct POPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPA>(arg0, 6, b"POPA", b"popa dog", b"loved dog pepe $POPA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000098280_05101da9ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

