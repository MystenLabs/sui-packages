module 0x21b0e0297a92386ba419fd52face91aa5ef93cc87e9dc2cd8ca9072676c5eece::usdtsui {
    struct USDTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTSUI>(arg0, 9, b"USDTSUI", b"Tether on ", b"USDT on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a02f7d96-b306-435f-b04f-7aed18476bf8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

