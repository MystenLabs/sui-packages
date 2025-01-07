module 0x9c7c4ca67e195289bddd5ab3a9727554a99f6db6d3f0c17d2e536ea657cef2f0::bullio {
    struct BULLIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLIO>(arg0, 6, b"BULLIO", b"Bulio", b"$BULIO is a community-driven crypto meme coin on Solana. $BULIO is a symbol of unity and fairness. With no single entity in charge, we embrace decentralization and invite all to join our mission to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4534534_933f0d9a93.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

