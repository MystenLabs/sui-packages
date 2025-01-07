module 0x6313725360720b095c780c5f80934bd3d9891dd263f9d6f00ffcc8685313583e::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 6, b"Suicide", b"Suicide Token", x"f09f92a7e29ca8205375696369646520436f696e20e29ca8f09f92a70a0a5375696369646520436f696e2069732061206d656d6520746f6b656e206f6e207468652053554920626c6f636b636861696e20776974682061206d697373696f6e20746f2073707265616420706f736974697669747920616e64207261697365206d656e74616c206865616c74682061776172656e6573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954961280.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

