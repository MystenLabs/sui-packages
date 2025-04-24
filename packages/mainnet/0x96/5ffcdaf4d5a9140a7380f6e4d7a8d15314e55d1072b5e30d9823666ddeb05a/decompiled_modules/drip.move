module 0x965ffcdaf4d5a9140a7380f6e4d7a8d15314e55d1072b5e30d9823666ddeb05a::drip {
    struct DRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIP>(arg0, 6, b"DRIP", b"MoonDRIP", b"MOONDRIP DRIP is a playful meme coin launched on the MoonBags Launchpad within the Sui blockchain ecosystem where wet vibes meet dripping potential. MOONDRIP embodies the essence of a dripping moon symbolizing endless flow, liquidity, and fun in the crypto space. As a meme project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid6j7flvicsmbasyq5mkcfi4lsmlf3l5b3iiajlnyv3pgie7xdpsy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

