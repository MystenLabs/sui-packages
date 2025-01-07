module 0x63e30fb28cd8270012663d983f374ef4284f619280e06ac34d4b455fa8b0e8d0::sir {
    struct SIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIR>(arg0, 6, b"SIR", b"SIRANO", b"Good Lider Cripto Mem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733674412271.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

