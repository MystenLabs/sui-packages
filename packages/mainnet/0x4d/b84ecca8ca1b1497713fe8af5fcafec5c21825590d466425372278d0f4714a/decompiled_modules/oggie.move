module 0x4db84ecca8ca1b1497713fe8af5fcafec5c21825590d466425372278d0f4714a::oggie {
    struct OGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGIE>(arg0, 6, b"OGGIE", b"OGGIESUI", b"$OGGIE - Story of Oggie and beanstalk from Big Yum Yum Book", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tx0_JH_Dku_400x400_c75a617bf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

