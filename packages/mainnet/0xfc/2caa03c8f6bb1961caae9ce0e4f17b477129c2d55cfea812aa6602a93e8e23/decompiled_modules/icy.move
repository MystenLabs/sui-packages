module 0xfc2caa03c8f6bb1961caae9ce0e4f17b477129c2d55cfea812aa6602a93e8e23::icy {
    struct ICY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICY>(arg0, 6, b"ICY", b"ICY BEAR", b"ICY the SUI Bear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gf_Ed_Ps_ac_AAH_Nqs_edac603335.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICY>>(v1);
    }

    // decompiled from Move bytecode v6
}

