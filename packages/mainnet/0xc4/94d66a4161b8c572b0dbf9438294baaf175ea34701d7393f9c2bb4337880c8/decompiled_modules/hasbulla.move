module 0xc494d66a4161b8c572b0dbf9438294baaf175ea34701d7393f9c2bb4337880c8::hasbulla {
    struct HASBULLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASBULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASBULLA>(arg0, 6, b"HASBULLA", b"Hasbulla Sui", b"HASBULLA is the newest cryptocurrency inspired by the famous internet sensation, Hasbulla Magomedov.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_logo_2_192x192_2002ce65a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASBULLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASBULLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

