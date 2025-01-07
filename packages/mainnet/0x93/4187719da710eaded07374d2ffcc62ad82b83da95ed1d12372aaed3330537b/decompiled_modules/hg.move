module 0x934187719da710eaded07374d2ffcc62ad82b83da95ed1d12372aaed3330537b::hg {
    struct HG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HG>(arg0, 6, b"HG", b"hg", b" huge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w700d1q75cms_8ca4f48a7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HG>>(v1);
    }

    // decompiled from Move bytecode v6
}

