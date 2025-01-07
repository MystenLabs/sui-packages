module 0xf377799061db4ff34363608c008791e461f2c830ce13670d5cb8d1fa242c01af::moist {
    struct MOIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOIST>(arg0, 6, b"MOIST", b"moist", b"Sui, the water network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moist_9866b72184.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

