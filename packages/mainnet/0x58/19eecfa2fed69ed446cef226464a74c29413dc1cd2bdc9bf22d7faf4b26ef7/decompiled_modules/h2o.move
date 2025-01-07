module 0x5819eecfa2fed69ed446cef226464a74c29413dc1cd2bdc9bf22d7faf4b26ef7::h2o {
    struct H2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: H2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H2O>(arg0, 6, b"H2O", b"Sui Mascot", b"H2O is supported by the strongest community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h2o_3a8015cff0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H2O>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H2O>>(v1);
    }

    // decompiled from Move bytecode v6
}

