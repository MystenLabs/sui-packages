module 0x514855f31a7c229f020282e4f84f6daf9cc8233c2075052cb78f014b53a68af2::cringe {
    struct CRINGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRINGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRINGE>(arg0, 6, b"CRINGE", b"CRINGE ON SUI", b"Cringe is Good Cult", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_454deaef19.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRINGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRINGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

