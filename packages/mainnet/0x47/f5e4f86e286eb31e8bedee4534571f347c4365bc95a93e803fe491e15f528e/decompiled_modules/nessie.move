module 0x47f5e4f86e286eb31e8bedee4534571f347c4365bc95a93e803fe491e15f528e::nessie {
    struct NESSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NESSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NESSIE>(arg0, 6, b"Nessie", b"Nessie Sui", b"People call me Loch Ness Monster but my friends just call me Nessie, I live on Loch Ness Lake and don't eat humans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ness_9a8276962a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NESSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NESSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

