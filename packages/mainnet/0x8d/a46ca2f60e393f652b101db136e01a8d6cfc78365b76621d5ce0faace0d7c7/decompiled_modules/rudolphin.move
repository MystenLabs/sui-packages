module 0x8da46ca2f60e393f652b101db136e01a8d6cfc78365b76621d5ce0faace0d7c7::rudolphin {
    struct RUDOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUDOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUDOLPHIN>(arg0, 6, b"RUDOLPHIN", b"Rudolphin", b"Rudolphin the red nose... reindeer or dolphin?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_fec49f52cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUDOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUDOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

