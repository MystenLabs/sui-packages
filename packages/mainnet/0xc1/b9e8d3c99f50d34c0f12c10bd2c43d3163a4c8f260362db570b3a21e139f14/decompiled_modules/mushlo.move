module 0xc1b9e8d3c99f50d34c0f12c10bd2c43d3163a4c8f260362db570b3a21e139f14::mushlo {
    struct MUSHLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHLO>(arg0, 9, b"MUSHLO", b"WAVE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8cdc0538-d281-4224-9e7d-3cb995ef9d5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSHLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

