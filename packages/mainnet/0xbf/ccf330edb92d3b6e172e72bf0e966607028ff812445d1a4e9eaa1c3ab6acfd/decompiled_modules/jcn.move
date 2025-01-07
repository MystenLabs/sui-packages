module 0xbfccf330edb92d3b6e172e72bf0e966607028ff812445d1a4e9eaa1c3ab6acfd::jcn {
    struct JCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JCN>(arg0, 6, b"JCN", b"JOHNN SUIINA", b"THIS IS THE ONE AND ONLY JOOOOOOHNNNN CENAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/412_a6d96a1cc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

