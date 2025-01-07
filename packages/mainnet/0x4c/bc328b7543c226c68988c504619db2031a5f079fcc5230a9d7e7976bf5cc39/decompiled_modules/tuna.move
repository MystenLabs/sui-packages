module 0x4cbc328b7543c226c68988c504619db2031a5f079fcc5230a9d7e7976bf5cc39::tuna {
    struct TUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNA>(arg0, 9, b"TUNA", b"AQUATUNA", b"Inspired by the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e0bfcf4-981b-4aae-a138-3971874c6669.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

