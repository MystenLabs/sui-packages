module 0x8754b1c77bcc0f21a233fe9fe101f76971789e491a5e4ca634715b8a9503f4b3::killno {
    struct KILLNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLNO>(arg0, 6, b"KILLNO", b"Killno", b"Welcome to killno - a cute magical scorpion ready to kill but actually loving", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052763_a02ba0bd77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

