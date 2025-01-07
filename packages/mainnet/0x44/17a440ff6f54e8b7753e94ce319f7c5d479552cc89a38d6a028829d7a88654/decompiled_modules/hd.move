module 0x4417a440ff6f54e8b7753e94ce319f7c5d479552cc89a38d6a028829d7a88654::hd {
    struct HD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HD>(arg0, 6, b"HD", b"Hopdie", b"sui is foster but hopisdie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049329_c2bbd4b726.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HD>>(v1);
    }

    // decompiled from Move bytecode v6
}

