module 0xe21e5ee5eabb4a1e4295543bada1e700dd07cbac69f80ba60fa2908cf7bb69ca::mugen {
    struct MUGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUGEN>(arg0, 9, b"MUGEN", b"MUU GEN", b"M UU GEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b05865b-178c-4f74-b0a0-4554316eabc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

