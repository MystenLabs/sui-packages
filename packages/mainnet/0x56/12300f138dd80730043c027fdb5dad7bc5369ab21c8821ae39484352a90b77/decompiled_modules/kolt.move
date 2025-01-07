module 0x5612300f138dd80730043c027fdb5dad7bc5369ab21c8821ae39484352a90b77::kolt {
    struct KOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLT>(arg0, 6, b"KOLT", b"Kolt Sui", x"244b4f4c54202d2054616b696e67204f766572205355490a0a4b6f6c742069732074686520636f6f6c65737420636174206f6e205355492e20496e73706972656420627920746865204c6567656e646172792064726177696e6773206f66204d617474204675726965732720426f79277320436c756220436f6d6963", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_4_af0da3168d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

