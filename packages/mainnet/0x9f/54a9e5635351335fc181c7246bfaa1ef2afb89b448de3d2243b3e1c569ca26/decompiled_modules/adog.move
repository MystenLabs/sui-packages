module 0x9f54a9e5635351335fc181c7246bfaa1ef2afb89b448de3d2243b3e1c569ca26::adog {
    struct ADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADOG>(arg0, 6, b"ADoG", b"Awesome DoG", b"Awesome DoG ($ADoG)  is a meme-inspired token with real-world utility, built on the Sui blockchain. Focusing on Web3 gaming , $ADoG offers a fun, engaging way for users to earn and use tokens within decentralized applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727157184351_fc2f31f7d3086749b53c0fd68c4137a7_70e1247407.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

