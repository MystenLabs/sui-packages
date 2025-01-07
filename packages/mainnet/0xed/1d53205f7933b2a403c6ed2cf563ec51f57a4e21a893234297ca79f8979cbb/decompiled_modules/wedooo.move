module 0xed1d53205f7933b2a403c6ed2cf563ec51f57a4e21a893234297ca79f8979cbb::wedooo {
    struct WEDOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOOO>(arg0, 9, b"WEDOOO", b"WAVE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f82aea9-901b-49a0-83e7-09983b42acde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

