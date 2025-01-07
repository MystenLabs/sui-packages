module 0x4dbd741646a64dc4801e140e316530d1df84184a2e440403b3a148557c29275b::sushi {
    struct SUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSHI>(arg0, 6, b"Sushi", b"SU$HI", b"SU$HI is the innovative token on the SUI blockchain, serving as a delicious bridge between crypto and culinary experiences. Think of it as the middleman that transforms your investments into gourmet adventures. With SU$HI, you can indulge in mouthwatering meals while building your crypto portfolio, making every bite a step closer to that dream lambo. Whether youre dining out or enjoying home-cooked dishes, SU$HI is your ticket to savoring lifes finest flavors in style. Join the SU$HI community and taste the future of food and finance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/360_F_734835975_X5_E_Ub_Zb_S1w_Ym_MT_Xc_Uf_GX_5_XO_Jh3xf_V_Bm_H_8937ffafec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

