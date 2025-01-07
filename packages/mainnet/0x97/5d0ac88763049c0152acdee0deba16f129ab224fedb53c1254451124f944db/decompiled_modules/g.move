module 0x975d0ac88763049c0152acdee0deba16f129ab224fedb53c1254451124f944db::g {
    struct G has drop {
        dummy_field: bool,
    }

    fun init(arg0: G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G>(arg0, 9, b"G", b"TH", b"BV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a76caf3-0858-4ec6-abc7-2e6bcd1e9ba6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G>>(v1);
    }

    // decompiled from Move bytecode v6
}

