module 0x60b188a37e6e3226a08b39b59047a6a96184ae84e89519b2f7ae6ba6b9584391::skl {
    struct SKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKL>(arg0, 6, b"SKL", b"Sparkling Love on sui", b"We are happy to welcome you to the Sparkling Love community. Let's share sweet moments with us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_08_10_11_43_53c69d7b60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

