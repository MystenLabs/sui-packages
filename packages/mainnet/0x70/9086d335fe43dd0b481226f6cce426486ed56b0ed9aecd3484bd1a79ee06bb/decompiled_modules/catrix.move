module 0x709086d335fe43dd0b481226f6cce426486ed56b0ed9aecd3484bd1a79ee06bb::catrix {
    struct CATRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATRIX>(arg0, 6, b"CATRIX", b"CAT IN THE MATRIX", x"43415420494e20544845204d41545249580a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gq_SH_Suc_W_400x400_0ff0f969e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATRIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATRIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

