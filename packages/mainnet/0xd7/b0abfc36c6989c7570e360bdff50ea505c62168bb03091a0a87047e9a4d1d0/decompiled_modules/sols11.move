module 0xd7b0abfc36c6989c7570e360bdff50ea505c62168bb03091a0a87047e9a4d1d0::sols11 {
    struct SOLS11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLS11, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLS11>(arg0, 6, b"Sols11", b"sols", b"Inscription fever will return", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730896421753.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLS11>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLS11>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

