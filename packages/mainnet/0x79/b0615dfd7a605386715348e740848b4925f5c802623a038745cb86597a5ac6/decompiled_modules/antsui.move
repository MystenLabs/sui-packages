module 0x79b0615dfd7a605386715348e740848b4925f5c802623a038745cb86597a5ac6::antsui {
    struct ANTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTSUI>(arg0, 6, b"ANTSUI", b"ANT ON SUI", b"ANTSUI is a meme of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cha_I_o_THAI_NH_VIEI_N_mo_I_I_i_b27bafd3a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

