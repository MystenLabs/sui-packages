module 0x77ff88bc3277285933985fe07c5e89c9afc768de46f546ee834c0e665e71eb28::frump {
    struct FRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUMP>(arg0, 6, b"FRUMP", b"Frenchie Trump", b"Lets just have some fun and build a community together! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7182_15ad9778ca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

