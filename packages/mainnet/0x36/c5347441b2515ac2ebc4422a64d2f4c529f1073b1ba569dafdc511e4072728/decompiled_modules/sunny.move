module 0x36c5347441b2515ac2ebc4422a64d2f4c529f1073b1ba569dafdc511e4072728::sunny {
    struct SUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNNY>(arg0, 6, b"SUNNY", b"SuiSun", b"Cheerful mascot riding the rocket of success on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sinny_275b77b137.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

