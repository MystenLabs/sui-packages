module 0xfaeb4b1c0f976c8d350a5dab0864aef9bb339b07ec85b6703415a1ec05694764::hos {
    struct HOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOS>(arg0, 6, b"HOS", b"Hamstr on sui", b"Hamstr on sui ...... To the Moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000412715_8bfe1a8816.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

