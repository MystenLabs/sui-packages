module 0x9560855aef828820b96e647c8afd3a7c73de635c6fae8d0ffa3d37956bffe181::poshi {
    struct POSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSHI>(arg0, 6, b"POSHI", b"Poshi purple", b"Poshi purple on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000041918_a7c92fecf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

