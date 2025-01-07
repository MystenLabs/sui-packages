module 0x23387a5d5502fbeaa92e5e3cac6dddb90ce76f7e8378901b001493d51a6b1e20::sim {
    struct SIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIM>(arg0, 9, b"SIM", b"Simbas", b"One more cat wants eat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1475149-1c64-4d13-94ac-e2ba81d57085.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

