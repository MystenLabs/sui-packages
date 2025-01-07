module 0x3ba5c0272180a9f68912d8676dbeb6741ef461c7fa556be90b12af63c690fca1::bub {
    struct BUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUB>(arg0, 6, b"BUB", b"Bubbles", b"Each bubble holds value but can burst at any moment, releasing its value to the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bubb_19d8a9070a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

