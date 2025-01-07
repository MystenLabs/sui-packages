module 0x6fb5e0d65ef4ed63043ce1be45e592aa7bdd5d0aa0f4684a6ef241b7ba653b05::birddog {
    struct BIRDDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDDOG>(arg0, 6, b"BIRDDOG", b"bird-dog", b"5th member of the Boys Club ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_duck_w_text_baed151420.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

