module 0x301d9ba03899a3cc46516872ca4abfffa2e223e998dfb78e8139673e5bf01c12::oggie {
    struct OGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGIE>(arg0, 6, b"OGGIE", b"First Oggie On Sui", b"OGGIE -  Matt Furie 's Frog |  Official link: oggieonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_1_3_b1c4be2f5a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

