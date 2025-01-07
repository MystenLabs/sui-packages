module 0x659fe249f93d920a93dd8de2ef4f7967155ce4aa21ad98851b370765a08dfc49::keset {
    struct KESET has drop {
        dummy_field: bool,
    }

    fun init(arg0: KESET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KESET>(arg0, 9, b"KESET", b"Keseti", b"sst sst sst..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffb92e92-9549-4009-b18e-4a1d2aaea2b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KESET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KESET>>(v1);
    }

    // decompiled from Move bytecode v6
}

