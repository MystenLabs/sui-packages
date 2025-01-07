module 0x1fa7a56e486592c9b6ddfeb3c13c161e489dc4ed9a40e3a3fe961e7d57628c59::vbnmbn {
    struct VBNMBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VBNMBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VBNMBN>(arg0, 9, b"VBNMBN", b"FGHFG", b"GHJKL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/397eb072-1d28-41ec-b53a-097ce8b3e6fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VBNMBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VBNMBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

