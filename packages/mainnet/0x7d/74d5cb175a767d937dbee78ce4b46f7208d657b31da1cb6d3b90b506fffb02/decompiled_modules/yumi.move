module 0x7d74d5cb175a767d937dbee78ce4b46f7208d657b31da1cb6d3b90b506fffb02::yumi {
    struct YUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMI>(arg0, 6, b"YUMI", b"YUUMI SUI", b"The top cat token of Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_10_9f94cace46.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

