module 0xd66122e940c1819c2b9df482d3192036345a787da6c34204b1240889982f6c30::ama {
    struct AMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMA>(arg0, 6, b"AMA", b"SUIAMA", b"Meet SUI, the llama who loves to keep fit and have a blast while doing it! In the vibrant savannah of Sunnylands, Solama is the ultimate fitness enthusiast. With a heart full of energy and a passion for movement, he leads the way in fun workouts, proving that exercising is way more enjoyable with friends by your side!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ti_RP_Wuh4c1th_Rc4p_V_Jtf_X_Aan_Koo_WR_8_E8do_Rrzm5_Ceggf_f44194147f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

