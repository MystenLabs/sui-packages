module 0x6c3658def49142f97ce186b574c2b1dd4402c9d9457d6809f3c490253dc9dc9::pdog {
    struct PDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOG>(arg0, 6, b"PDOG", b"Punk Dog", b"Punk Dog, prepare for x1000 no socials send it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005749_11f73f233c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

