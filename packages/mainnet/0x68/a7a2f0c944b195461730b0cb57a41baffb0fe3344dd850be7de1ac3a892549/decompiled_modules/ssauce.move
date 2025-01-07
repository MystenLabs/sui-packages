module 0x68a7a2f0c944b195461730b0cb57a41baffb0fe3344dd850be7de1ac3a892549::ssauce {
    struct SSAUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAUCE>(arg0, 6, b"Ssauce", b"SUI SAUCE", x"53697a7a6c6520616e6420537061726b6c652077697468205375692053617563652120e29ca82054686520686f7474657374206e6577206d656d6520636f696e206f6e2074686520537569206e6574776f726b2e204a6f696e2074686520706172747920616e64206c65742773206d616b6520686973746f727920746f6765746865722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731098448526.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSAUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

