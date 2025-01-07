module 0xeed2a9d8c2e706d72f84db3bdbe3919a15d1e4ca6f7a32cea6ce997d87527f0f::skitty {
    struct SKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITTY>(arg0, 6, b"Skitty", b"Suikitty", b"The hello kitty of the Sui network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9406_0cd9f20be4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

