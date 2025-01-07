module 0xd2f59bbf1fe55cee8da37eb5314e268e332abd4d3750c96407d7534ab25195be::golang {
    struct GOLANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLANG>(arg0, 6, b"GoLang", b"GoLang Coin", x"476f4c616e6720436f696e73212066756e6e7920616e642066756e6e79206d656d652063727970746f63757272656e6379206174207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_25_03b642b968.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

