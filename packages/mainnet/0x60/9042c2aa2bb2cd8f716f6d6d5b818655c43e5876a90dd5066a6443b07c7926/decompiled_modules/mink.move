module 0x609042c2aa2bb2cd8f716f6d6d5b818655c43e5876a90dd5066a6443b07c7926::mink {
    struct MINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINK>(arg0, 6, b"MINK", b"MINK ON SUI", b"Mink on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956323161.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

