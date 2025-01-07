module 0x4afb85da57836fb3e4ad2ab9678976fe3a1ff2e34eaaad347aafe1da8064027c::a2z {
    struct A2Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: A2Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A2Z>(arg0, 9, b"A2Z", b"A2ZCOIN ", b"BINANCE LAB LAUNCHPOOL PROJECT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cbbde223-aecd-4524-adaa-8c0d74628422.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A2Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A2Z>>(v1);
    }

    // decompiled from Move bytecode v6
}

