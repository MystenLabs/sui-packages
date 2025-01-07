module 0x1397af6f3c5f323f984661c2fa66ee3bb0cefe775f53ad006aac22bb28f088a::donzilla {
    struct DONZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONZILLA>(arg0, 6, b"DONZILLA", b"The Godzilla Father - ON SUI NETWORK", b"Don Zilla, head of a mafia family, decides to hand over his empire to his youngest son, SUIzilla. However, his decision unintentionally puts the lives of his loved ones in grave danger.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_b54f0f8c1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

