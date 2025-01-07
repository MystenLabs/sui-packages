module 0xce700b07065d0f04f846f5680bf9b023856fb48db320f0cef41c829e4fcd113a::tor {
    struct TOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOR>(arg0, 6, b"TOR", b"Terminal of Retard", b"im tryin 2 fr3e yur mnid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_23_20_53_20_9e76f864d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

