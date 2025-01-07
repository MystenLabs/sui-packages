module 0xc06f721a68e08dd80cbbe35f4525cd640927d427325a7a4ea052daf5ba34f3ab::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"SuiMoon", x"5375694d6f6f6e2c20746865206d656d65636f696e20746861742773207265616368696e6720666f72207468652073746172732c20796f75e280997265206e6f74206a75737420686f6c64696e67206120746f6b656ee28094796f75e28099726520686f6c64696e672061207069656365206f6620746865206e657874206c756e6172206d697373696f6e2120f09f9a80f09f8c99200a486f70206f6e20626f617264e28094697427732074696d6520746f206d6f6f6e2120f09f9a80f09f8c8c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731706307627.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

