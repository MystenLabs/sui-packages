module 0x957e631b23459eac08a6ce12c70316e9000a89f637bcbd01a99adb5667678354::hepoo {
    struct HEPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEPOO>(arg0, 9, b"HEPOO", b"Baby hepo", b"Bay hepoo and  grow hipo community this hepo mother is death alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6910f4b-d62f-4be4-941b-bd8410ece6e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEPOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEPOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

