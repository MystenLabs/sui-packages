module 0x839247ea854f3f7fd8f6ff9aaa780a34378371468ac1bf1bc07e535f27201d39::cetlaacaish {
    struct CETLAACAISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETLAACAISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETLAACAISH>(arg0, 9, b"CetlaaCaish", b"Cetlaa Caish", b"CetaceanToken is a digital asset inspired by the majestic creatures of the ocean, whales (Cetacea). This token is designed to symbolize strength, resilience, and the preservation of marine ecosystems, focusing on long-term stability and growth. Just as whales navigate vast oceans, CetaceanToken aims to become a symbol of power and agility in the crypto world, providing a secure and reliable ecosystem for its users.  With CetaceanToken, we support sustainability efforts and promote eco-friendly financial innovation. Every transaction reflects a commitment to maintaining balance in both the digital world and nature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CETLAACAISH>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETLAACAISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CETLAACAISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

