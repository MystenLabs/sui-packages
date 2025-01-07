module 0xab89f30296c5e87ce27757e59c9350389df6e619a7bcc5c479971f16dffa5a87::pepebull {
    struct PEPEBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEBULL>(arg0, 6, b"PEPEBULL", b"PEPE BULL", b"$PEPEBULL is ready to RAM in SUI OCEAN!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PROFILE_PIC_X_transformed_9571aa04a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

