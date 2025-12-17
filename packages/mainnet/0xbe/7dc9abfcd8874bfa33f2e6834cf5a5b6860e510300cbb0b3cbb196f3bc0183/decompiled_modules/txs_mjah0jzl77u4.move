module 0xbe7dc9abfcd8874bfa33f2e6834cf5a5b6860e510300cbb0b3cbb196f3bc0183::txs_mjah0jzl77u4 {
    struct TXS_MJAH0JZL77U4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TXS_MJAH0JZL77U4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TXS_MJAH0JZL77U4>(arg0, 9, b"TXS", b"Cowboy Dallas", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmPp34WS7ZhTPBLqcuT78NhsZ96JkPPMg7xvwwDVccyaa3")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TXS_MJAH0JZL77U4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TXS_MJAH0JZL77U4>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

