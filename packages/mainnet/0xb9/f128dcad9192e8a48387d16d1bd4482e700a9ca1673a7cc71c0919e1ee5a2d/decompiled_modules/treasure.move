module 0xb9f128dcad9192e8a48387d16d1bd4482e700a9ca1673a7cc71c0919e1ee5a2d::treasure {
    struct TREASURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREASURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURE>(arg0, 6, b"Treasure", b"Treasure Quests", b"https://x.com/TreasureQuests_", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mosnter_35ae4a72d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREASURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREASURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

