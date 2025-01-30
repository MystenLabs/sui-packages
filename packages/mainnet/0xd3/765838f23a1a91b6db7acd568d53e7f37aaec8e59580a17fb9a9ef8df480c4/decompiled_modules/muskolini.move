module 0xd3765838f23a1a91b6db7acd568d53e7f37aaec8e59580a17fb9a9ef8df480c4::muskolini {
    struct MUSKOLINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSKOLINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSKOLINI>(arg0, 6, b"Muskolini", b"Benelon Muskolini", b"Pure Elon vibes. He Naziing, they loving him", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9hhl67_6d892d6bfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSKOLINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSKOLINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

