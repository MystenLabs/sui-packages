module 0xebdd0c95b6780c0c72a15cee371c63d76a11134e6f41e4e6d51fa848edc95428::shp {
    struct SHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHP>(arg0, 9, b"SHP", b"shrimp", x"4469766520696e746f2064656c6963696f75732070726f66697473207769746820536872696d70636f696ef09f8da4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2db987a-ca33-40e5-948f-b6247d0904ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

