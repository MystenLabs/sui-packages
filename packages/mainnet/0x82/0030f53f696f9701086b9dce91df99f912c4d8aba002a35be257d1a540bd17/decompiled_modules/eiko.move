module 0x820030f53f696f9701086b9dce91df99f912c4d8aba002a35be257d1a540bd17::eiko {
    struct EIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EIKO>(arg0, 6, b"EIKO", b"Sui Eiko 6900", b"Once upon a motherboard, deep in the neon-lit servers of a top-secret AI research lab, a new digital entity was born. They named it EIKO 6900, an evolution of the Eliza . Dev wallet will send to eliza .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250117_224530_e7768194af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

