module 0x63fcf98bd3ec1c3d78b3cb307e5d1f50fd543227ba5f19c80b58853b7e0cc33a::suli {
    struct SULI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULI>(arg0, 6, b"SULI", b"SULI on Sui", b"$Suli - Surviving SUl's twists and turns. Code warrior by day, crypto enthusiast by night.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0384_c040cc4851.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULI>>(v1);
    }

    // decompiled from Move bytecode v6
}

