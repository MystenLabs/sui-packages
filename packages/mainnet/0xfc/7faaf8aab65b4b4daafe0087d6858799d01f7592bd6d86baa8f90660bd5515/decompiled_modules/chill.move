module 0xfc7faaf8aab65b4b4daafe0087d6858799d01f7592bd6d86baa8f90660bd5515::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILL>(arg0, 9, b"CHILL", b"ChillCoin", x"5a656e20696e206120746f6b656e2e204561726e204348494c4c207468726f756768206d656469746174696f6e2c20627265617468696e67206578657263697365732c20616e64206d696e6466756c6e6573732e20546865206c6f77657220796f757220686561727420726174652c207468652068696768657220796f757220726577617264732e20496465616c20666f722077656c6c6e657373206170707320616e642064652d73747265737320636f6d6d756e69746965732e204a75737420627265617468652e2e2e20616e64206561726e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d2d23638291834d9749fa20fe5d00967blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

