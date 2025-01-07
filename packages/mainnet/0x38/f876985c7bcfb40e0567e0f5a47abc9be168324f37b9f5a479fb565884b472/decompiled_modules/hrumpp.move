module 0x38f876985c7bcfb40e0567e0f5a47abc9be168324f37b9f5a479fb565884b472::hrumpp {
    struct HRUMPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRUMPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRUMPP>(arg0, 6, b"Hrumpp", b"Hrump", b"Hrump as like Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5497_04b00e1757.GIF")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRUMPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRUMPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

