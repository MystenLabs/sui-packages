module 0xd85d2e6ff1feb6a0c0abe27aa052c78afee1626527e7c371abac75e718d95b47::cryptome {
    struct CRYPTOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTOME>(arg0, 9, b"CRYPTOME", b"Memoe", x"4368c3a16e206368c3a16e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea3c254d-20f3-4f84-9c22-a3667c5ed44b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

