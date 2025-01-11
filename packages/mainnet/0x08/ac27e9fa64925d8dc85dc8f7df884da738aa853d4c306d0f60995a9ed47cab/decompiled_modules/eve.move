module 0x8ac27e9fa64925d8dc85dc8f7df884da738aa853d4c306d0f60995a9ed47cab::eve {
    struct EVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVE>(arg0, 6, b"Eve", b"EVE", b"Eve is a community-driven cryptocurrency project that aims to bridge the gap between emerging blockchain technology and everyday users. With a vision to make decentralized finance (DeFi) more intuitive and inclusive, Eve is building a robust ecosystem that combines powerful tools with seamless usability ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_749466f814.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

