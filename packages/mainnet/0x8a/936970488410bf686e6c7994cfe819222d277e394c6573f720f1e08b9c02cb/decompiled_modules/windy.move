module 0x8a936970488410bf686e6c7994cfe819222d277e394c6573f720f1e08b9c02cb::windy {
    struct WINDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINDY>(arg0, 6, b"WINDY", b"WINDY COIN", x"537461727420796f7572206a6f75726e657920696e746f207468652063727970746f20776f726c6420776974682057494e44592e0a0a54656c656772616d203a2068747470733a2f2f742e6d652f57696e64796f6e7375690a54776974746572202f20583a2068747470733a2f2f782e636f6d2f77696e6479636f696e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745460452652.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

