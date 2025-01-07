module 0x90fe0c23a9093e39c8bac8c56ebe6df29fb067cd3bd3450ac215ecf863d0b871::dws {
    struct DWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWS>(arg0, 6, b"DWS", b"Dog Wif Snake", b"First Dog Wif Snake on Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_28_at_6_15_34a_AM_be29b40f70.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

