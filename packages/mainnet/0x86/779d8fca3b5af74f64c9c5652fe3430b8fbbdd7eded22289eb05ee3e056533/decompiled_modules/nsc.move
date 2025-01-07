module 0x86779d8fca3b5af74f64c9c5652fe3430b8fbbdd7eded22289eb05ee3e056533::nsc {
    struct NSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSC>(arg0, 9, b"NSC", b"NHU SO CUT", b"Never Heat Upper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4701fbf-ebba-4b6c-83a5-1e8b0c324373.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

