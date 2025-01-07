module 0x1279dbcf381191dba8925c0f1b5f2999fd20ae5306240a7e4121da26983c58a9::mokito {
    struct MOKITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKITO>(arg0, 6, b"MOKITO", b"SUI MOKITO", b"$MOKITO : Inspired by MOKITO's legendary Discord antics and the Polite Cat meme, $MOKITO is ready to take over the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_100_f15376db1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOKITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

