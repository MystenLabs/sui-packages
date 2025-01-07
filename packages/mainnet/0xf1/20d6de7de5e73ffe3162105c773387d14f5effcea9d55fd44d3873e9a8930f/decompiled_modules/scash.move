module 0xf120d6de7de5e73ffe3162105c773387d14f5effcea9d55fd44d3873e9a8930f::scash {
    struct SCASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCASH>(arg0, 6, b"SCASH", b"SuiCASH", x"317374205375696361736820696e2053554920424c4f434b434841494e205769746e6573732075732066726f6d203020746f2042494c4c494f4e2024204d61726b65746361700a0a43616e27742073746f7020776f6e27742073746f7020287468696e6b696e672061626f7574205375692920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_cash_39a325fad1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

