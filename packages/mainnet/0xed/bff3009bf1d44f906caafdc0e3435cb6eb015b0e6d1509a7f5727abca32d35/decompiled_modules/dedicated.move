module 0xedbff3009bf1d44f906caafdc0e3435cb6eb015b0e6d1509a7f5727abca32d35::dedicated {
    struct DEDICATED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEDICATED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEDICATED>(arg0, 6, b"DEDICATED", b"Dedicated on SUI", b"Dedications pretty simpleits just about showing up, no matter what. Its putting in the work when no ones watching and staying locked in, even when quitting would be way easier. Its not about huge moves, just small, consistent steps. Deep breath. Stay calm. Trust the process. Youre not gonna see results overnight, but you know theyll come if you keep going. Its not about feeling motivated all the timeits about having the discipline to stick with it. And thats exactly what this coin represents: focus, patience, and the grind that pays off. Youre not just holding a coinyoure holding a mindset, a reminder that success isnt luck, its earned. Dont just watchbe a part of it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdf_E_Wmd_Xx_Lr_Euq_X_Er9_K7_P3pij_N2p9xr_G_Uvy_P_Tgy_F_Zey_VL_15d86a39c5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEDICATED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEDICATED>>(v1);
    }

    // decompiled from Move bytecode v6
}

