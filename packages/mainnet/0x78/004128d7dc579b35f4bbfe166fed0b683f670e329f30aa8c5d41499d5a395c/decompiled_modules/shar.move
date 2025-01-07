module 0x78004128d7dc579b35f4bbfe166fed0b683f670e329f30aa8c5d41499d5a395c::shar {
    struct SHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAR>(arg0, 6, b"SHAR", b"Sharpei Sui", b"It's all about experiences", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_841c3f345b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

