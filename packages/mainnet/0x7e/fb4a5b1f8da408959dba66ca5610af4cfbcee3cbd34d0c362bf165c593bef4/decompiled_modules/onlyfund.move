module 0x7efb4a5b1f8da408959dba66ca5610af4cfbcee3cbd34d0c362bf165c593bef4::onlyfund {
    struct ONLYFUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYFUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYFUND>(arg0, 6, b"OnlyFund", b"OnlyFund.fun", x"456d706f776572696e672063727970746f20646f6e6174696f6e7320776974682073696d706c696369747920616e64207365637572697479e28094636f6e6e6563742c206372656174652c20616e64206d616b6520616e20696d7061637421204f6e6c7946756e642c206c696b6520476f46756e644d652062757420706f77657265642062792063727970746f63757272656e63792c206973206120706c6174666f726d2077686572652067656e65726f73697479206d6565747320696e6e6f766174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736013558429.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONLYFUND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYFUND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

