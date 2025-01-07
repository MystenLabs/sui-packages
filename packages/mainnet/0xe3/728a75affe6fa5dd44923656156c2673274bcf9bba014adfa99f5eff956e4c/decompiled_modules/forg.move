module 0xe3728a75affe6fa5dd44923656156c2673274bcf9bba014adfa99f5eff956e4c::forg {
    struct FORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORG>(arg0, 6, b"FORG", b"Forg by Matt Furie on Sui", b"Forg brings a playful twist to the crypto landscape!Join us: https://forgbymattfuriecoin.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_l1_e1730009021884_192x192_4d2ee98a15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

