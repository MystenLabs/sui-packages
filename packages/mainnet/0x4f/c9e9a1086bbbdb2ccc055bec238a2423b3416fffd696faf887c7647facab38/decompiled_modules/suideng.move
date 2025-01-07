module 0x4fc9e9a1086bbbdb2ccc055bec238a2423b3416fffd696faf887c7647facab38::suideng {
    struct SUIDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDENG>(arg0, 6, b"SUIDENG", b"Sui Moodeng", b"In the vibrant world of the Sui Chain, a famous digital hippo, known for its playful charm, became a symbol of resilience and creativity. This blockchain-based character roamed virtual marketplaces, where its unique traits and stories captivated collectors and developers alike. With every transaction, the hippo's legend grew, representing the adventurous spirit of the Sui Chain community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_3d1f820e0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

