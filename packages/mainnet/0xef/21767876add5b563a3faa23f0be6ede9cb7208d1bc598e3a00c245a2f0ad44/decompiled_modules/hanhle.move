module 0xef21767876add5b563a3faa23f0be6ede9cb7208d1bc598e3a00c245a2f0ad44::hanhle {
    struct HANHLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANHLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANHLE>(arg0, 9, b"HANHLE", b"HANHLE Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://lh3.googleusercontent.com/a-/ALV-UjWMxIm2DR0NfDrWzmxuVI2HWtW8oYY6trwtHTV34AfwtTUU-8vf=s88-w88-h88-c-k-no"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HANHLE>(&mut v2, 100000000000000000, @0x5300ccbb61ca3d8665c1bdb57da71dd221cf65e78f960bd23a8aea83d10559ca, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANHLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANHLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

