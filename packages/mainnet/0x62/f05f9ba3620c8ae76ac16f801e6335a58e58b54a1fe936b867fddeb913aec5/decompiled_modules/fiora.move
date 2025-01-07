module 0x62f05f9ba3620c8ae76ac16f801e6335a58e58b54a1fe936b867fddeb913aec5::fiora {
    struct FIORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIORA>(arg0, 6, b"FIORA", b"Fiona Sui", b"The story of Fiona the hippo stands out as a unique blend of cultural phenomenon and blockchain innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/faq_7259acba3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

