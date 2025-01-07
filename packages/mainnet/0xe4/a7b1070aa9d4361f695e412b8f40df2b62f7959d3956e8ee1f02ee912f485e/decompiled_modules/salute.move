module 0xe4a7b1070aa9d4361f695e412b8f40df2b62f7959d3956e8ee1f02ee912f485e::salute {
    struct SALUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALUTE>(arg0, 6, b"SALUTE", b"salute cat", b"salute cat on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731011983988.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALUTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALUTE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

