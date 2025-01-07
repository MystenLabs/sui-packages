module 0x515622258113afa895084575ee1f630969d902e1e2cfe4f91d8dc5b5cd1c01ad::splo {
    struct SPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLO>(arg0, 6, b"SPLO", b"splosplashsui", x"416c6c20696e2c20616c6c2073706c6173682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SPLO_68a0299c30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

