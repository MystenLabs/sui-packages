module 0xba5cd242cb105a0e058602495c16d92ccba4ffd3523ffb8f8ce0d730871c413a::SEAL {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 6, b"Sappy Seals", b"SEAL", b"$SEALS is all about fun in the sun and good vibes. Join our cute seal squad for a playful, community-driven meme coin experience. No drama, just seals chillin' and memes thrillin'!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/ilw6mtHjqJ5gP1pefhy6BtqGs6nvfg7mF0dwbHOq95ZdcfXUB/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, @0x82ea3f8d2475bae1d2aba484c46125fdb81e0f192172e398c2ee99d9813cea00);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

