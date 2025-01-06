module 0xe4fbeed7f08b9a3a3701cbf733091a6f27fefdb4c190f43e9853ed2066690c0f::h2o {
    struct H2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: H2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H2O>(arg0, 6, b"H2O", b"H2O", b"H2+O2=H2O", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/784-0x0b998e7490971775b2e4197a679f39a14d864a15aeaf5fcf9f76ba0feb8416af::H2O::H2O-98.png/type=default_350_0?v=1735795107146&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H2O>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<H2O>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H2O>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

