module 0x60ed5b07c0ff59b58c55336555511260a5038090dea0661a2217d339a0e1cc83::sdg {
    struct SDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDG>(arg0, 6, b"SDG", b"Sui Dogs", b"Sui Dogs is a meme token. its fully suppoted by community. we drop 10% supply of airdrop if we reached 10 Million marketcap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_12_202954_bf5f26feea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

