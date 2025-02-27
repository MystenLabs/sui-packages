module 0x11aa7e21acd15b1a25fe375b1b3c7aef6c1b3dec3522b812d0d521e90f61557e::rsui {
    struct RSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSUI>(arg0, 9, b"RSUI", b"RSUI", b"RSUI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/nfttokenasa/image/upload/v1740644506/qavcs7etnm0ko0q4z3r6.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

