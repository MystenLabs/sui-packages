module 0xec096ecfb75435ddfebc47f2ea5f01fff520395cb51e828cfa6c09002c030e10::wire {
    struct WIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIRE>(arg0, 6, b"WIRE", b"Wire Liberty Fence", b"wirelibertyfence.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732297302961.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIRE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

