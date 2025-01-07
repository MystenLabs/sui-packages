module 0xef92450ca160c12e258dd4841a6434552c72cee0088c2b32cccf3acbbe7d7e4b::sse {
    struct SSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSE>(arg0, 6, b"SSE", b"SUI SEASON", b"It's about to be a suinami. SUI Season on SUI - the one and only SSE token adopting a PVE/PVP mindset and creating a movement of unity on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3448_6ad17d1ca0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

