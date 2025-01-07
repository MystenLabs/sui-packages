module 0x9ade65d4729d5d4b1cd2000f86c0b22dcb74edbaf3e0ebbf089b1543aac44513::gttrump {
    struct GTTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTTRUMP>(arg0, 6, b"GtTrump", b"Grand Theft Trump", b"Welcome to GtTrump. Sui memecoin, bringing trump narratives and video games. You can download and play and earn. let's make video games great again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_GT_TRUMP_a6f7bf2fef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

