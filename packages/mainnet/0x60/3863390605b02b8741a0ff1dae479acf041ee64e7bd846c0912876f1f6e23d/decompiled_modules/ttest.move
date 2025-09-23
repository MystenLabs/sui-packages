module 0x603863390605b02b8741a0ff1dae479acf041ee64e7bd846c0912876f1f6e23d::ttest {
    struct TTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTEST>(arg0, 9, b"TTEST", b"TTtest", b"This is Test Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://s3-symbol-logo.tradingview.com/crypto/XTVCETH--big.svg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TTEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTEST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TTEST>>(v2);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

