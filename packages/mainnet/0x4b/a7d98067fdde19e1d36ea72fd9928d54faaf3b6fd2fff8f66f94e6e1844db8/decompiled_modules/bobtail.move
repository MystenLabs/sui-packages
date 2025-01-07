module 0x4ba7d98067fdde19e1d36ea72fd9928d54faaf3b6fd2fff8f66f94e6e1844db8::bobtail {
    struct BOBTAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBTAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBTAIL>(arg0, 6, b"BOBTAIL", b"JAPONBASE SUI", b"The Japanese Bobtail cat is one breed of cat that is unique in that it has the shape of a bundle tail. This breed of cat also comes from Japan as its name has existed in the country since thousands of centuries ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241016_215335_861_a7b43252a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBTAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBTAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

