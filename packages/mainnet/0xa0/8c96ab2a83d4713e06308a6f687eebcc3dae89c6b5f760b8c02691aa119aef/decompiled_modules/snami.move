module 0xa08c96ab2a83d4713e06308a6f687eebcc3dae89c6b5f760b8c02691aa119aef::snami {
    struct SNAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAMI>(arg0, 6, b"SNAMI", b"SUINAMI", b"Suinami is a powerful community-driven meme token riding the waves of the Sui network fast, fun and unstoppable. join the sui surge ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1744871851483_4691a699d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

