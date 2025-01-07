module 0x68343bab343a78e536af2c77617a00f47f12547be7b38dcd6e8054c6cec582f5::dogwiftie {
    struct DOGWIFTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFTIE>(arg0, 6, b"DogWifTie", b"Dog Wif Tie", x"54686520646f672d776974682d74696520636f696e206973206d6f7265207468616e206a7573742061206d656d65e280946974e2809973206120756e697175652063727970746f63757272656e63792064657369676e656420746f206275696c642061206c6f79616c2c20656e676167656420636f6d6d756e6974792061726f756e6420612066756e206964656e746974792e20576974682067616d696669656420726577617264732c2075736572732063616e206561726e20746f6b656e732062792070617274696369706174696e6720696e206372656174697665206368616c6c656e6765732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731183528248.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGWIFTIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFTIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

