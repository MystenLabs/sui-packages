module 0xad707a5dffa005fc74563d6103a459abc29e11401542daa3883cec7513178cd0::catermelon {
    struct CATERMELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATERMELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATERMELON>(arg0, 6, b"CATERMELON", b"CATER MELON", b"no web, no telegram, just a catermelon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7839_431e375499.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATERMELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATERMELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

