module 0x9848ddd3aa5ce37234f1816a266a6905a037bbbe024f9383f419885c6f44a432::hanhle {
    struct HANHLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANHLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANHLE>(arg0, 9, b"HANHLE", b"HANHLE Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://lh3.googleusercontent.com/a-/ALV-UjWMxIm2DR0NfDrWzmxuVI2HWtW8oYY6trwtHTV34AfwtTUU-8vf=s88-w88-h88-c-k-no"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HANHLE>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANHLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANHLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

