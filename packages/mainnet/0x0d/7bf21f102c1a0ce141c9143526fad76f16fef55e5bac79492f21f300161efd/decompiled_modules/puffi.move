module 0xd7bf21f102c1a0ce141c9143526fad76f16fef55e5bac79492f21f300161efd::puffi {
    struct PUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFI>(arg0, 6, b"Puffi", b"Sui Puffi", b"Puffi is the  puffer fish of the meme coin world, bringing the fun and charm with it. Its got the cool factor AND  unique style. Built on the Sui blockchain, Puffi is here to make waves and pump up the meme coin game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puff_profile_5af174fe3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

