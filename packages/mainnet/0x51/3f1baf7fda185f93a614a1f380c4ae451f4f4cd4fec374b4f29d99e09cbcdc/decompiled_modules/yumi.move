module 0x513f1baf7fda185f93a614a1f380c4ae451f4f4cd4fec374b4f29d99e09cbcdc::yumi {
    struct YUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMI>(arg0, 6, b"YUMI", b"YUUMI SUI", b"YUUMISUI is your ally in the crypto world, with a touch of humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_10_b4676bea87.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

