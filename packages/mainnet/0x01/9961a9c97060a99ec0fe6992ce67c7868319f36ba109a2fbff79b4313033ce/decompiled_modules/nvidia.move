module 0x19961a9c97060a99ec0fe6992ce67c7868319f36ba109a2fbff79b4313033ce::nvidia {
    struct NVIDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVIDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVIDIA>(arg0, 6, b"NVIDIA", b"Nvidia", b"nvidia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731808039136.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NVIDIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NVIDIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

