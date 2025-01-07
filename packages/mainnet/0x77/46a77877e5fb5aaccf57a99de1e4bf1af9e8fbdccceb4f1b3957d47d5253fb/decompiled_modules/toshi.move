module 0x7746a77877e5fb5aaccf57a99de1e4bf1af9e8fbdccceb4f1b3957d47d5253fb::toshi {
    struct TOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSHI>(arg0, 6, b"TOSHI", b"First Toshi on Sui", b"First Toshi on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66743d14224d507f3565f7dd_Toshi_Logo_Circular_2_0e388ae43a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

