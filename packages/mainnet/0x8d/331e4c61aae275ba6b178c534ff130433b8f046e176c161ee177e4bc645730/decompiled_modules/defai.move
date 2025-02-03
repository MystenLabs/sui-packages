module 0x8d331e4c61aae275ba6b178c534ff130433b8f046e176c161ee177e4bc645730::defai {
    struct DEFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFAI>(arg0, 6, b"DeFAI", b"Eliza Defai", b"Eliza Defai revolutionizes DeFi with Agentic AI, offering adaptive, secure, and user-centric financial services", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2394_18bd35823a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEFAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

