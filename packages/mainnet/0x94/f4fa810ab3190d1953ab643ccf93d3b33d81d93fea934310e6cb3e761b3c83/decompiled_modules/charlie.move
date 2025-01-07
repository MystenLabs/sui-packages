module 0x94f4fa810ab3190d1953ab643ccf93d3b33d81d93fea934310e6cb3e761b3c83::charlie {
    struct CHARLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARLIE>(arg0, 6, b"CHARLIE", b"Surfing Dog", b"Charlie the Labrador is a regular at the World Dog Surfing Championships. He can pull the board to and from the water by himself, as well as do tricks like a 360 on wave take-offs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_6e28596167.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARLIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARLIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

