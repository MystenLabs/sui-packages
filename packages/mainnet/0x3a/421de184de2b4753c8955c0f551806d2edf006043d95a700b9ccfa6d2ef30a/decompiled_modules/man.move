module 0x3a421de184de2b4753c8955c0f551806d2edf006043d95a700b9ccfa6d2ef30a::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 6, b"MAN", b"LIFE OF A", b"A mans life is defined by the decisions he makes. $MAN will be your best on-chain decision. It's how you live your life. Embrace it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241212_110002_624_7b8d23f8c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

