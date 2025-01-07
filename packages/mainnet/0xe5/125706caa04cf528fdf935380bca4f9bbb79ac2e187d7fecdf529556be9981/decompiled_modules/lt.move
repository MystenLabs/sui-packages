module 0xe5125706caa04cf528fdf935380bca4f9bbb79ac2e187d7fecdf529556be9981::lt {
    struct LT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LT>(arg0, 9, b"LT", b"Luci Thao", x"5468e1baa36f2076c3ba2062e1bbb1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/936755d0-7d2f-4a73-b2b0-8e5aef469a2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LT>>(v1);
    }

    // decompiled from Move bytecode v6
}

