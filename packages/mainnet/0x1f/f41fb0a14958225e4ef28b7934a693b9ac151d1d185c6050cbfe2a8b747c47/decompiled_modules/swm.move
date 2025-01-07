module 0x1ff41fb0a14958225e4ef28b7934a693b9ac151d1d185c6050cbfe2a8b747c47::swm {
    struct SWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWM>(arg0, 6, b"SWM", b"Sui Women", b"Sui Women is a new cryptocurrency coin that is part of an NFT (Non-Fungible Token) release on the Sui network. Designed to empower and celebrate women's contributions, it aims to create a unique digital asset ecosystem centered around womens art, culture, and innovation. Built on the fast and scalable Sui blockchain, Sui Women NFTs provide exclusive ownership and utility features for collectors and creators, offering a secure, decentralized way to trade, showcase, and invest in digital assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006223_c011cc2751.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWM>>(v1);
    }

    // decompiled from Move bytecode v6
}

