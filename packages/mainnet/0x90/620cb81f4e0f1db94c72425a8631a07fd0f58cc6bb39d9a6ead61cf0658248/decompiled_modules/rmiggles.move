module 0x90620cb81f4e0f1db94c72425a8631a07fd0f58cc6bb39d9a6ead61cf0658248::rmiggles {
    struct RMIGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMIGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMIGGLES>(arg0, 6, b"RMIGGLES", b"ReverseMIGGLES", b"MiiIIaaAoOuuU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MIGGLES_7bce4fd98f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMIGGLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RMIGGLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

