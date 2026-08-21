module 0x47971e0da1dcec03e8faa47c8ec17aaad9b55c15d0147eb68786c28044e38c0b::hHAWAL {
    struct HHAWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHAWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHAWAL>(arg0, 9, b"hHAWAL", b"hHAWAL Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/hhawal_27c09733.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HHAWAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHAWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

