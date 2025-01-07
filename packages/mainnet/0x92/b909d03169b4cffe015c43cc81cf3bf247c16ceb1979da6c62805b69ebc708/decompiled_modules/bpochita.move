module 0x92b909d03169b4cffe015c43cc81cf3bf247c16ceb1979da6c62805b69ebc708::bpochita {
    struct BPOCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPOCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPOCHITA>(arg0, 6, b"BPOCHITA", b"Baby Pochita", b"BABY POCHITA JUST BORN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_08_07_00_b40af347c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPOCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPOCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

