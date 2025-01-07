module 0x4cec5c1a1625428b3f7d10e60fc0865e5717dc8e97687f5357090e0321c210b5::wcats {
    struct WCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCATS>(arg0, 9, b"WCATS", b"WEWE", b"Hi you my baby to day ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe4809fc-16ef-4c55-995f-7443cc75eb9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

