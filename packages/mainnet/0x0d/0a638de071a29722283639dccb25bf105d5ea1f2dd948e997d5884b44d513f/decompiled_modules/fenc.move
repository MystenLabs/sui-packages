module 0xd0a638de071a29722283639dccb25bf105d5ea1f2dd948e997d5884b44d513f::fenc {
    struct FENC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENC>(arg0, 6, b"FENC", b"Fennec Protocol", b"Fennec Protocol is a high-performance Sui token protocol inspired by the agility and intelligence of the fennec fox. It delivers secure, scalable, and efficient solutions for decentralized finance, offering innovative tools for staking, yield farming, and fast transactions. Built to empower DeFi users, Fennec Protocol combines adaptability and resilience, providing a seamless and trustworthy experience in the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fd8c5107_4785_4419_9897_8dadc1949474_670802098d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENC>>(v1);
    }

    // decompiled from Move bytecode v6
}

