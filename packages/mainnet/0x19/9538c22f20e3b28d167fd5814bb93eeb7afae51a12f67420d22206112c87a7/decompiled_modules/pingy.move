module 0x199538c22f20e3b28d167fd5814bb93eeb7afae51a12f67420d22206112c87a7::pingy {
    struct PINGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGY>(arg0, 6, b"PINGY", b"PINGY SUI", b"Welcome to the frosty yet surprisingly heartwarming world of PINGY, where our aspirations soar as high as our flaps can take usstraight to the moon, or at least a few inches off the ground, but whos measuring?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_pingy_aa0485705a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

