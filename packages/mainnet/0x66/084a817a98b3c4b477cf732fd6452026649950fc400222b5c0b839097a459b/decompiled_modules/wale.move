module 0x66084a817a98b3c4b477cf732fd6452026649950fc400222b5c0b839097a459b::wale {
    struct WALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALE>(arg0, 6, b"WALE", b"SuiWale", b"SuiWale - WALE is a revolutionary memecoin on the Sui blockchain that combines the power of crypto whales with the fun and accessibility of meme culture. Designed to appeal to crypto enthusiasts of all levels, SUIWale brings together playful humor, aquatic aesthetics, and real-world utility, creating a token thats as fun to use as it is rewarding to hold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d825c0c5f0a6840512b978357bd44526blob_c5f13a9478.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

