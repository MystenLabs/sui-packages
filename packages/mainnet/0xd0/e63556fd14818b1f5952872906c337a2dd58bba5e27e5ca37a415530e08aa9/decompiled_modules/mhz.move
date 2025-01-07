module 0xd0e63556fd14818b1f5952872906c337a2dd58bba5e27e5ca37a415530e08aa9::mhz {
    struct MHZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHZ>(arg0, 9, b"MHZ", b"Mehrzad", b"Mhz the best light token in city.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e582fc0-67c2-4467-8049-5cbe24e21d85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

