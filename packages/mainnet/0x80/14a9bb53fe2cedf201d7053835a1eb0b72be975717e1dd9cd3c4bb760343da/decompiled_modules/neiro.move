module 0x8014a9bb53fe2cedf201d7053835a1eb0b72be975717e1dd9cd3c4bb760343da::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"aaa Neiro", b"aaa can't stop won't stop thinking about $NEIRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/neirio_36d79874ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

