module 0x6f848f19bee3983f2fed9f1cc7b567eb9fef5b12df22c42b607a0dffc0765d65::senny {
    struct SENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENNY>(arg0, 6, b"SENNY", b"Sui Kenny", b"Oh my gawd, don't kill Sui Kenny, you bastards!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030386_043ae0f1e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

