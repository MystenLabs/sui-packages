module 0xd02116de01b7520758488950a1a64fb4ba19e0e6793ec0ce7dd544cf16d8a18a::Ball {
    struct BALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALL>(arg0, 9, b"BL", b"Ball", b"its a ball", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1425737051899564040/KeRAoaXO_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

