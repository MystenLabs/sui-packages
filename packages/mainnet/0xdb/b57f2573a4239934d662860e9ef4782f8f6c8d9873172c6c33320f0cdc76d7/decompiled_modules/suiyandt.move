module 0xdbb57f2573a4239934d662860e9ef4782f8f6c8d9873172c6c33320f0cdc76d7::suiyandt {
    struct SUIYANDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYANDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYANDT>(arg0, 6, b"SuiyanDT", b"Suiper Suiyan Trump", b"Forst Suiper Suiyan Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736602588013.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIYANDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYANDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

