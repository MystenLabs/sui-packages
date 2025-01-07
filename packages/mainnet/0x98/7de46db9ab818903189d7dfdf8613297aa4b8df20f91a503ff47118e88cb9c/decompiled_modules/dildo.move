module 0x987de46db9ab818903189d7dfdf8613297aa4b8df20f91a503ff47118e88cb9c::dildo {
    struct DILDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DILDO>(arg0, 6, b"DILDO", b"Dildo Sui", b"Dildo meme coin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000797_26dfec6939.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DILDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

