module 0x928058c43f1eb640aca1c8e465791f85422d73305a23e25dddb2be4ab8899043::aback {
    struct ABACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABACK>(arg0, 6, b"ABACK", b"Adam Back", b"The creator of bitcoin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_b003e6f7f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

