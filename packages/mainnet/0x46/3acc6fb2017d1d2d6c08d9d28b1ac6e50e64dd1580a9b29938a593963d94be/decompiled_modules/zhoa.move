module 0x463acc6fb2017d1d2d6c08d9d28b1ac6e50e64dd1580a9b29938a593963d94be::zhoa {
    struct ZHOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHOA>(arg0, 6, b"ZHOA", b"Chengpang", b"TG: https://t.me/ZHOAonBNB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_Np0_KUHT_400x400_75290b2557.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZHOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

