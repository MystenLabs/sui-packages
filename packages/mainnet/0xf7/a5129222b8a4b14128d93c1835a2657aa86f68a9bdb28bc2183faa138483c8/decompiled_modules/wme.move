module 0xf7a5129222b8a4b14128d93c1835a2657aa86f68a9bdb28bc2183faa138483c8::wme {
    struct WME has drop {
        dummy_field: bool,
    }

    fun init(arg0: WME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WME>(arg0, 9, b"WME", b"Weme ", b"Memecoin built under wave pump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24d16c97-2e64-457e-99c6-ca325586ed2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WME>>(v1);
    }

    // decompiled from Move bytecode v6
}

