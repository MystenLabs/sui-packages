module 0x298084b134abaab625f05352bf4505e1021ec8c055a1c80c9be6748606b341b7::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"AllinAI", b"catch that AI hype", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_05_150930_d4db009af2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

