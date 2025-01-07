module 0x380d8d305fe4c860a2cb15edb7c377def3c92316424fe988aad9557fa267c6d0::hso {
    struct HSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSO>(arg0, 6, b"HSO", b"Honorable Sui Overlord", b"Here here : by my decree, I demand your servitude to your great Overlord. Thou may think the vile HSO hasth the upper hand, but thou is gravely mistaken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4441_d50946ff86.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

