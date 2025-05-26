module 0xa796d4c857595579126045815ecb81c956aba13eadce23ac975611177695861c::davinci {
    struct DAVINCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVINCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVINCI>(arg0, 6, b"DAVINCI", b"Da Vinci", b"just a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748244645637.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAVINCI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVINCI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

