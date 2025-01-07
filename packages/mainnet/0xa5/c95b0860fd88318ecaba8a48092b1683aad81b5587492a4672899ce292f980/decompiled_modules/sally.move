module 0xa5c95b0860fd88318ecaba8a48092b1683aad81b5587492a4672899ce292f980::sally {
    struct SALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALLY>(arg0, 6, b"Sally", b"Salamanders", b"Salamanders Sally is a unique digital collectible on the Sui blockchain, featuring the charming character Sally the Salamander. Its part of a growing ecosystem of NFTs and digital assets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7056_fc5ef813ab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

