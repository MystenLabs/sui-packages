module 0x373abd00842878e6512418c9e0a93eb8e215d71dabd675d6a30338d9da50770a::nitro {
    struct NITRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NITRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NITRO>(arg0, 6, b"Nitro", b"Nitro on Sui ", x"53756974726f2069732061206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e2074686174e280997320616c6c2061626f75742073706565642c2066756e2c20616e6420656666696369656e63792e2041732061206d656d6520636f696e2c20697420636f6d62696e65732068756d6f7220776974682074686520706f74656e7469616c20666f72207261706964207472616e73616374696f6e7320616e64206869676820706572666f726d616e6365206f6e207468", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954817130.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NITRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NITRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

