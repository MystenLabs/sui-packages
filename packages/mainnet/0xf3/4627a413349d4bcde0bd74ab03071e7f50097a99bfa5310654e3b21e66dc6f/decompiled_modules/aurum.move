module 0xf34627a413349d4bcde0bd74ab03071e7f50097a99bfa5310654e3b21e66dc6f::aurum {
    struct AURUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURUM>(arg0, 9, b"AURUM", b"KING AURUM", b"JUST A LION KING FROM UK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/701c6b57-3887-4064-a781-1252244994ec-1000068409.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

