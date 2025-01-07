module 0x9c264638aa464ce2bae3e8d5a1d17e9fedf6b929c56571dc63e04e5acd589b0::bobosui {
    struct BOBOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBOSUI>(arg0, 6, b"BOBOSUI", b"BOBO SUI", b"$BOBO Invest in the Bear, thrive in the Bull.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_50f05639f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

