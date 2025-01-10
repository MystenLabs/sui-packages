module 0x71b2ed56e7b909d647e315ac7ac0a7011eda790f3e1ade3f549f960541754051::rbt {
    struct RBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBT>(arg0, 6, b"RBT", b"Rabbit Ai", b"Rabbit Ai  project combining the power of AI and metaverse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736523809622.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

