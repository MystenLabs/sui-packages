module 0x6c025b1a55488ef00ae781e4a9c28d7add76001f9a715ce7501d69a9f130d946::fugly {
    struct FUGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUGLY>(arg0, 6, b"FUGLY", b"Fugly on sui", b"The duckling that's fugly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_09c8fc54ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

