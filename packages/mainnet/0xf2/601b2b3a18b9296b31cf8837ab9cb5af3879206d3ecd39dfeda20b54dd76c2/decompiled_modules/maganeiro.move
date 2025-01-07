module 0xf2601b2b3a18b9296b31cf8837ab9cb5af3879206d3ecd39dfeda20b54dd76c2::maganeiro {
    struct MAGANEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGANEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGANEIRO>(arg0, 6, b"MAGANEIRO", b"MAGA  NEIRO", b"The friendly dog. Born to make dog coins great again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Te_Qmor_UY_Jf_WZSK_5d116_C2_S8ch_X6njtod_YN_Rb2q_Jz_ZUF_4_49b94e9544.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGANEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGANEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

