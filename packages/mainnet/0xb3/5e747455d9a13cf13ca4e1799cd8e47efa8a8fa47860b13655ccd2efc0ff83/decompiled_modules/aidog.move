module 0xb35e747455d9a13cf13ca4e1799cd8e47efa8a8fa47860b13655ccd2efc0ff83::aidog {
    struct AIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOG>(arg0, 6, b"AIDog", b"Sui AIDog", b"Hey, I'm not a very capable person, so I need your help to fill it up. This is our first step towards victory together, joining the AIDog team.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_G_Ze_KH_Hi_400x400_3fff54f4f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

