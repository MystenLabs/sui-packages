module 0x2f7640f736997928609218bed784a01463e8e53f2510ebfb76b94bc51036fd08::wa {
    struct WA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WA>(arg0, 6, b"WA", b"WAGYU", b"Steak Your Claim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_1_0e6fd8c2f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WA>>(v1);
    }

    // decompiled from Move bytecode v6
}

