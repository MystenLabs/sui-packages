module 0x8a73c74933ea62e5a090a0ca851c2e33b152732e895e967bb2e972c1ee967ea1::css {
    struct CSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSS>(arg0, 9, b"CSS", b"cx", b"sss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.thenounproject.com/png/447685-200.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

