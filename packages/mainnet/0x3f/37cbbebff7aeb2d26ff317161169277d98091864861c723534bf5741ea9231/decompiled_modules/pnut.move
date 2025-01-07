module 0x3f37cbbebff7aeb2d26ff317161169277d98091864861c723534bf5741ea9231::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"Pnut", b"Peanut the Squirrel", b"little Squirrel on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nd_Tt_Jauw39u4_Dz_Gy_Ta_Z35r_Rx4_Vg_Axqb91w_E89zjy_H_Wd2_9e8b4e584e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

