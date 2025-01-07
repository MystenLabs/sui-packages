module 0xc8c4d592347cb8528cf8feb1798fe9f1b58226a804a431727cd5570a9ead4943::sagi {
    struct SAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGI>(arg0, 6, b"SAGI", b"SUI AGI", b"$SAGI is for those who love chaos, cuteness, and the thrill of the meme world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_94_2c25d37ca5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

