module 0xb03ddae3afa623550efe3eb621611b60bea93361326ef572149c88a6e9acae86::suimonke {
    struct SUIMONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONKE>(arg0, 6, b"SUIMONKE", b"Sui Monke", b"Pure banana on Sui Blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimonkey_9914a12d98.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

