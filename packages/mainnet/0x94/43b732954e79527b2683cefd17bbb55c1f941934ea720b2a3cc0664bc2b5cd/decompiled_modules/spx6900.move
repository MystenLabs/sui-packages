module 0x9443b732954e79527b2683cefd17bbb55c1f941934ea720b2a3cc0664bc2b5cd::spx6900 {
    struct SPX6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX6900>(arg0, 9, b"SPX6900", b"Spx", b"Market bullish spx6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60c9c5cb-6591-4176-bfff-0dcd3ccfecc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPX6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

