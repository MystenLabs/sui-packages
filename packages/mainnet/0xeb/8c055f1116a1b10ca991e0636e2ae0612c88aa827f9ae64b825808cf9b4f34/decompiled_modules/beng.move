module 0xeb8c055f1116a1b10ca991e0636e2ae0612c88aa827f9ae64b825808cf9b4f34::beng {
    struct BENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENG>(arg0, 6, b"BENG", b"blue eyed deng", b"A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.A blue eyed hippo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_fa3d9364c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

