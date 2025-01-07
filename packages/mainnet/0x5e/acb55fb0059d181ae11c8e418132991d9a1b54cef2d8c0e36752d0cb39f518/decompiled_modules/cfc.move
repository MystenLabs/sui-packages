module 0x5eacb55fb0059d181ae11c8e418132991d9a1b54cef2d8c0e36752d0cb39f518::cfc {
    struct CFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFC>(arg0, 9, b"CFC", b"CoffeeCoin", b"For the caffeine-addicted", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5a7f676-bcfa-4a79-b6c5-b18905ce4268.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

