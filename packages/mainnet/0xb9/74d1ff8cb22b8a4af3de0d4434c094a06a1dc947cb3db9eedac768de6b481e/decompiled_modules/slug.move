module 0xb974d1ff8cb22b8a4af3de0d4434c094a06a1dc947cb3db9eedac768de6b481e::slug {
    struct SLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUG>(arg0, 6, b"SLUG", b"SLUGGARDO", x"546865206d656d65636f696e20666f7220746865206465762077686f277320534c5547474953482e200a54616b652070617274206f6e2074686520756e646572646f67206f6620537569204d656d65636f696e732e0a436f6d6d756e6974792077696c6c2070756d702069742c2069742773206120686173736c652e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240924_191618_876_445880eee8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

