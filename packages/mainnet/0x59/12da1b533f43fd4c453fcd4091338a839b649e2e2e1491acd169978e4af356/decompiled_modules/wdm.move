module 0x5912da1b533f43fd4c453fcd4091338a839b649e2e2e1491acd169978e4af356::wdm {
    struct WDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDM>(arg0, 9, b"WDM", b"world m", b"WORLD IS M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ecdfa420-94f4-41b5-8bc5-de6b51a62402.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDM>>(v1);
    }

    // decompiled from Move bytecode v6
}

