module 0xcc8afbf30ea520adef67e47ed3cf4dabb77f246681f2b4f4832cc16718d9065::harris {
    struct HARRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRIS>(arg0, 9, b"HARRIS", b"Kamala", b"Vote meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c548a67-cbd2-4ec8-8072-d118bc6f2841.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

