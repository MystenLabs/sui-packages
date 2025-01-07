module 0x98157d115ea6bfffa069cd3df8db6ff16aa468f121845de56cbf40c3a7a3fb0c::sugmaz {
    struct SUGMAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGMAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGMAZ>(arg0, 6, b"SUGMAZ", b"Sui Sugmaz", b"$SUGMAZ - The only sack worth holding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732073862039.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUGMAZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGMAZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

