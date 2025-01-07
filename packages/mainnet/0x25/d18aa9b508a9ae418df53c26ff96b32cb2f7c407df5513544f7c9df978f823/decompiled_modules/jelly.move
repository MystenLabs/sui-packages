module 0x25d18aa9b508a9ae418df53c26ff96b32cb2f7c407df5513544f7c9df978f823::jelly {
    struct JELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLY>(arg0, 6, b"JELLY", b"Jelly Fish", b"JellyFish is the decentralized meme token that flows through the Sui Networks financial ecosystem like a jellyfish in the ocean. Squishy, zappy, and always in motion, JellyFish is the token for traders who want their portfolio to have a little extra sting.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_22_58_49_543ad54871.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

