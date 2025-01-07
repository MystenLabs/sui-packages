module 0x8f46c5413fc09f4190d55bb4a3b096ec7f80c807f759475039b5484cbd4aa697::suiteee {
    struct SUITEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEEE>(arg0, 6, b"Suiteee", b"Suiteee Cat", b"Sweetest cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000079182_7b20319b7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

