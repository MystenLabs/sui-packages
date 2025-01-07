module 0x9ede17f12ccd34cc4190515e97710ecfa853ef14c4fd751ce8efe03b83fd2a4d::oka {
    struct OKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKA>(arg0, 6, b"OKA", b"Oka Shiba Inu", b"The most famous Shiba Inu on WeChat & YouTube.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4357_e3226a4f25.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

