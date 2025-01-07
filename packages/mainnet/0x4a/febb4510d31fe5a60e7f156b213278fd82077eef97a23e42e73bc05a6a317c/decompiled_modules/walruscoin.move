module 0x4afebb4510d31fe5a60e7f156b213278fd82077eef97a23e42e73bc05a6a317c::walruscoin {
    struct WALRUSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUSCOIN>(arg0, 6, b"WalrusCoin", b"WalrusCash", x"47657420726561647920746f206469766520696e746f2074686520636f736d696320776f726c64206f662057616c7275732c2077686572652066756e206d656574732066696e616e6369616c2066726565646f6d2e205468697320696e7465727374656c6c61722077616c727573206861732074726164656420696e2068697320666c69707065727320666f7220612066757475726973746963207370616365737569742e0a7e204d6f766570756d707e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_nh_cha_p_m_A_n_h_A_nh_2024_10_17_222455_bfc42742f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUSCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALRUSCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

