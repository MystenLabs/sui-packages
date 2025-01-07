module 0xb6237c9a16f515a4c93092bb5d30a5e02889b1ba1baa091ea9b8157b785198f1::yui {
    struct YUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUI>(arg0, 6, b"YUI", b"Yuegui Sui", x"6a757374206120766972616c206c696c2062756e6e790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_8_f188600d9b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

