module 0xd8a6e7bfdd4c38e0a265fcbea53263c509c215d8367919065cc77c23e6de66c0::dom {
    struct DOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOM>(arg0, 6, b"DOM", b"DOM PEDRO", b"The DOM PEDRO. Coin is a meme coin inspired by the iconic Brazilian emperor, Dom Pedro. With the symbol $DOM, this token playfully embraces the concept of a \"decentralized monarchy,\" where holders are the \"nobles of the empire.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5829978655689_b28583bd37cd9da2bc23f9ebc05c14f5_1ca9e8e6aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

