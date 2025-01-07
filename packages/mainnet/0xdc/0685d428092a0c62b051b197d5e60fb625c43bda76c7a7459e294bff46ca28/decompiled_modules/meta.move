module 0xdc0685d428092a0c62b051b197d5e60fb625c43bda76c7a7459e294bff46ca28::meta {
    struct META has drop {
        dummy_field: bool,
    }

    fun init(arg0: META, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<META>(arg0, 9, b"META", b"MetaSuiX", b"MetaSuiX is a futuristic token on the Sui blockchain, designed for advanced use cases in decentralized finance and digital assets. The name suggests a focus on bridging blockchain technology with the metaverse, offering cutting-edge solutions in the digital ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1654537883066286093/s12qIjh6.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<META>(&mut v2, 125000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<META>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<META>>(v1);
    }

    // decompiled from Move bytecode v6
}

