module 0x8492d7020976c726decd28928c09f0ea2806b2bcaa63c36548ec6f7cecbb3220::guard {
    struct GUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUARD>(arg0, 6, b"GUARD", b"Guard Sui", b"Guard -  meme coin is inspired by the brave and strong lifeguards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002163_154b39b9d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

