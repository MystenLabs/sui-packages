module 0x3fa82754ddfb569cb5f57cc82f7d73adf3afb579bcf4b5c70cac1b96b42b0c0b::zaza {
    struct ZAZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAZA>(arg0, 9, b"ZAZA", b"ZAZA VOU", b"TEAM WORK IS KEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d9aaed9-8aac-4837-8ddf-2cd14e496955.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

