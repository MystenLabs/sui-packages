module 0x15797bc82572e2799eb98d2732a9e4d3b6854cd86d44e1e820d35dcb305d447b::milly {
    struct MILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILLY>(arg0, 6, b"MILLY", b"100M", b"100M is a fully decentralized, community-driven cryptocurrency, growing organically with no central control. Powered by its users, 100M is a movement for true transparency and fairness in crypto, where the community shapes the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5793_4d49a0a96a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

