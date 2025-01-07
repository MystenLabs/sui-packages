module 0xf5d366f2f7ca588d632bef149fd42902c06df2e850aec3bd52270b5b0ddf6d81::nye {
    struct NYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYE>(arg0, 6, b"NYE", b"NEW YEARS EVE", x"41207265766f6c7574696f6e6172792063727970746f63757272656e637920626c656e64696e67204e65772059656172e280997320737069726974207769746820746f6d6f72726f77e280997320746563686e6f6c6f67792e20496e7665737420696e20696e6e6f766174696f6e2c2063656c6562726174652074686520636f756e74646f776e2077697468206469676974616c20736563757269747920616e642066696e616e6369616c2066726565646f6d2e204e59453a205468652066757475726520737461727473206e6f772e2047657420726561647920746f207368696e6520696e20323032352120e29ca8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734914142677.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

