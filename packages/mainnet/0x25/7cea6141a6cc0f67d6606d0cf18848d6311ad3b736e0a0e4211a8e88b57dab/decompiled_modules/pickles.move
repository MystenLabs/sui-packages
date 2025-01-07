module 0x257cea6141a6cc0f67d6606d0cf18848d6311ad3b736e0a0e4211a8e88b57dab::pickles {
    struct PICKLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICKLES>(arg0, 6, b"Pickles", b"Mr. Pickles", b"Join this diabolical adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/il_570x_N_2698563995_oijg_ac78542823.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICKLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICKLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

