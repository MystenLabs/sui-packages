module 0x7d427f77885bdfe3d1f9953535f3627ed5337c56ce9abac69011f78ccb5f917f::mermaid {
    struct MERMAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERMAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERMAID>(arg0, 6, b"MERMAID", b"MERMAID SUI", b"MERMAID IS ANIME CHARACTER ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3597_75979b7da9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERMAID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERMAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

