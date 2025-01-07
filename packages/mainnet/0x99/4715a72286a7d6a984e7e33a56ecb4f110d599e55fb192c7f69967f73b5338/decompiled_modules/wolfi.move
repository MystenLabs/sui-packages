module 0x994715a72286a7d6a984e7e33a56ecb4f110d599e55fb192c7f69967f73b5338::wolfi {
    struct WOLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLFI>(arg0, 6, b"WOLFI", b"Wolfi by Matt Furie", b"Wolfi by Matt Furie, ready to dominate the world - starting with Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_1_min_183f3de1b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

