module 0xfa23a06f09d167733e3af8dd06fb76786d684c47a595a7bb49f5678ffcfe0071::dolpy {
    struct DOLPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPY>(arg0, 6, b"DOLPY", b"Dolpy", x"446f6c7079206973206d6f7265207468616e206a7573742061206d656d6520636f696e206974e280997320612073796d626f6c206f6620616d626974696f6e20616e642064657465726d696e6174696f6e20696e207468652072617069646c792067726f77696e672063727970746f63757272656e63792073706163652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731503778750.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

