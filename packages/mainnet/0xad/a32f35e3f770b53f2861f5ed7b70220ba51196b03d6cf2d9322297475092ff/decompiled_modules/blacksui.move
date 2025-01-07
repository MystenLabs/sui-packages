module 0xada32f35e3f770b53f2861f5ed7b70220ba51196b03d6cf2d9322297475092ff::blacksui {
    struct BLACKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKSUI>(arg0, 6, b"Blacksui", b"Black Sui ", x"446f6e27742073746f70200a576f6e27742073746f700a416c77617973207468696e6b696e672061626f757420737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965002366.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACKSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

