module 0x82618d17103ae9c1baa0f8761e0bc655303233744ecb71f5db6811f5b786ffed::gft {
    struct GFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFT>(arg0, 6, b"GFT", b"Goldfish Token", b"Goldfish Token (GFT) is a utility token on the Sui blockchain, powering staking, governance, and ecosystem transactions. It fosters growth and community-driven innovation in Web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goldfishlogo_02e7259d78.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

