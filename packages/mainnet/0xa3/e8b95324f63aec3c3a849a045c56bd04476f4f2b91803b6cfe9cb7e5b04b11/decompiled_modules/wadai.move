module 0xa3e8b95324f63aec3c3a849a045c56bd04476f4f2b91803b6cfe9cb7e5b04b11::wadai {
    struct WADAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WADAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WADAI>(arg0, 6, b"WADAI", b"WaddleWise On SUI", b"WaddleWise is not just a meme coin but a symbol of intelligence, curiosity and connection. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_10_0c4c43cf52.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WADAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WADAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

