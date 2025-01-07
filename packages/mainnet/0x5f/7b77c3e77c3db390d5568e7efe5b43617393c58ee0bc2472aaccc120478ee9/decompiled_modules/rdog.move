module 0x5f7b77c3e77c3db390d5568e7efe5b43617393c58ee0bc2472aaccc120478ee9::rdog {
    struct RDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDOG>(arg0, 6, b"rDOG", b"Repost Dog", b"Repost Dog on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ynf_R_Mmas_AMA_e_O_a132a74e22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

