module 0x97232bd13137feca0af8f2cd3b2aa6bc29d2501476a632b6bc4d28a80eacfe90::snochill {
    struct SNOCHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOCHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOCHILL>(arg0, 6, b"Snochill", b"Sui Nochill", b"nochill is present on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000063882_1a7b205603.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOCHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOCHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

