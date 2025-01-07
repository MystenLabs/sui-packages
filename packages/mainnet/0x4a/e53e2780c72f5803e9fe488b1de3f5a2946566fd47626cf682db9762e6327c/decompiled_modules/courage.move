module 0x4ae53e2780c72f5803e9fe488b1de3f5a2946566fd47626cf682db9762e6327c::courage {
    struct COURAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COURAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COURAGE>(arg0, 6, b"COURAGE", b"Courage Sui", b"Courage the paranoid sui dog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_16_32_50_7b8d119ddd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COURAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COURAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

