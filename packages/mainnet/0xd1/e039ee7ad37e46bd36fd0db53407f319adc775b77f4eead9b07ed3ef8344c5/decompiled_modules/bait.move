module 0xd1e039ee7ad37e46bd36fd0db53407f319adc775b77f4eead9b07ed3ef8344c5::bait {
    struct BAIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAIT>(arg0, 6, b"BAIT", b"Pixel Fishing", b"At a glance...Pixel Fishing is a meme coin project built on the Sui Network. But under the surface...Pixel Fishing is built on top of an innovative, time-based, manual reveal system that allows holders more control over what they ultimately get. The process is simple. The token holders starts by holding our $BAIT tokens which could be burnt to mint unrevealed \"Bait\" NFTs. Go visit our website to learn more about the project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_cbb610e8a1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

