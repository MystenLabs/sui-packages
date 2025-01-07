module 0x36b23f5a03e8d3ed2baa0ea4d6162e9ac7e8bcff1cdae75671c2e2eb3344e104::sba {
    struct SBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBA>(arg0, 6, b"SBA", b"SUI BORED APE", b"Introducing the Sui Bored Ape Token on the revolutionary SUI blockchain! Get ready for a whole new level of Token greatness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006120_72fd97ff44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

