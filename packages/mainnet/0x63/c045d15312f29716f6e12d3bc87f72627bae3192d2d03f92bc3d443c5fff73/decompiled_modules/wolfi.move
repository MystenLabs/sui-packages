module 0x63c045d15312f29716f6e12d3bc87f72627bae3192d2d03f92bc3d443c5fff73::wolfi {
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

