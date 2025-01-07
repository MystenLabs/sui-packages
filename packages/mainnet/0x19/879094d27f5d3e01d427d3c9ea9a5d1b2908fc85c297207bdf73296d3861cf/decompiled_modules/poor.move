module 0x19879094d27f5d3e01d427d3c9ea9a5d1b2908fc85c297207bdf73296d3861cf::poor {
    struct POOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOR>(arg0, 6, b"POOR", b"Poor On Sui", b"Poor - The crypto token for those who've lost it all in the pursuit of moonshots and Lambo dreams. Join the club of broke traders and hodlers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_b869fbe950.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

