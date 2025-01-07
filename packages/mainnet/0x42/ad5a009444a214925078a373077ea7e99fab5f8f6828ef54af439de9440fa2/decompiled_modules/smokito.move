module 0x42ad5a009444a214925078a373077ea7e99fab5f8f6828ef54af439de9440fa2::smokito {
    struct SMOKITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKITO>(arg0, 6, b"SMOKITO", b"MOKITO SUI", b"$MOKITO : Inspired by the viral YouTuber MOKITO and his legendary Discord adventures", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_100_9fa4a25e18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOKITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

