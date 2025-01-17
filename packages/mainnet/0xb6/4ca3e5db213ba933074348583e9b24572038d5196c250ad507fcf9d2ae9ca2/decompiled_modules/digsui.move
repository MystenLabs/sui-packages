module 0xb64ca3e5db213ba933074348583e9b24572038d5196c250ad507fcf9d2ae9ca2::digsui {
    struct DIGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIGSUI>(arg0, 6, b"DIGSUI", b"Diglett Sui", b"When the ground gets hot, I rise to the occasion!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/quality_restoration_20250118012334038_c2b3f1ce3a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

