module 0x977720529925e5f6a3f0a1a2d80004ab29a6932ce1d3e133f4216800d5606873::gup {
    struct GUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUP>(arg0, 9, b"GUP", b"GUPPY", b"guppy fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/632a3695-3677-42eb-a9cb-fc69050608c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

