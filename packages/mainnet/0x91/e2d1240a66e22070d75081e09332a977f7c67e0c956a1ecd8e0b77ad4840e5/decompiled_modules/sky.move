module 0x91e2d1240a66e22070d75081e09332a977f7c67e0c956a1ecd8e0b77ad4840e5::sky {
    struct SKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKY>(arg0, 6, b"Sky", b"Sky the Classy Dog", b"Sky the Classy Dog is a stylish and sophisticated memecoin that brings a touch of elegance to the crypto world. Inspired by a dapper dog with sleek fur and signature sunglasses, Sky embodies confidence, charm, and a flair for high-class living.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738712249963.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

