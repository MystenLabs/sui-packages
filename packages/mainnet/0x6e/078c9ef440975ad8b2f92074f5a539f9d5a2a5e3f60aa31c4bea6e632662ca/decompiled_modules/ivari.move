module 0x6e078c9ef440975ad8b2f92074f5a539f9d5a2a5e3f60aa31c4bea6e632662ca::ivari {
    struct IVARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVARI>(arg0, 6, b"Ivari", b"Ivari Ai", x"526561647920746f206c6f636b20696e20616e6420736861726520736f6d65206c6f76653f20497661726920414920697320796f757220616c6c2d696e2d6f6e6520636f6d70616e696f6e20666f722072656c6174696f6e73686970206164766963652c20706c617966756c2063686174732c20616e6420736d6172742074726164696e6720696e7369676874732e204c6574e2809973206d616b6520796f757220657870657269656e636520626f74682066756e20616e6420696e736967687466756c2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736131644375.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVARI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVARI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

