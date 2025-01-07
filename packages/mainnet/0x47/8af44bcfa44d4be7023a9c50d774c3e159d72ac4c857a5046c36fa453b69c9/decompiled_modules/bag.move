module 0x478af44bcfa44d4be7023a9c50d774c3e159d72ac4c857a5046c36fa453b69c9::bag {
    struct BAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAG>(arg0, 6, b"BAG", b"IKEA BAG", b"The cult is growing. We worship our bags. They will be pumped when the time is right. Come hop into the world's most iconic bag.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Kx_DJ_9rr_S5_Reh5_T8_VS_9_Jnrcr_XEP_5_V_Tw_Jeo_Ec_Mw_Mopump_4_f48e064f9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

