module 0xfe5c0c3a191d0be01cb5aa1cd43f1e18440d368e886b40e77c4d032b9e075d22::slim {
    struct SLIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIM>(arg0, 6, b"SLIM", b"Slime on Sui", x"536c696d6520546865206669727374206375746520666f726d6c6573730a6d6f6e73746572206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040957_15c647e5c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

