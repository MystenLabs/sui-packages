module 0x32737692e38bc635c9d66f5d0dd178a9f2dee853ebafe635701990913efcf982::amethyst {
    struct AMETHYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMETHYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMETHYST>(arg0, 6, b"Amethyst", b"1.2 Steven Universe", b"1.2 More in coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Amethyst_Steven_Universe_ecbb8eb821.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMETHYST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMETHYST>>(v1);
    }

    // decompiled from Move bytecode v6
}

