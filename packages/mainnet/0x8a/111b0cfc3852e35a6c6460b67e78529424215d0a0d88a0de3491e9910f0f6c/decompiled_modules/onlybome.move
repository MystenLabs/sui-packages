module 0x8a111b0cfc3852e35a6c6460b67e78529424215d0a0d88a0de3491e9910f0f6c::onlybome {
    struct ONLYBOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYBOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYBOME>(arg0, 6, b"Onlybome", b"Suibome", b"The suibome meme will definitely be number one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8887_43b44ffc16.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYBOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONLYBOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

