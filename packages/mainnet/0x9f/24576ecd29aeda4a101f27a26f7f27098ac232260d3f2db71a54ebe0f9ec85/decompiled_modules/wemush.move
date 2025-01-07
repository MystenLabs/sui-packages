module 0x9f24576ecd29aeda4a101f27a26f7f27098ac232260d3f2db71a54ebe0f9ec85::wemush {
    struct WEMUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEMUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEMUSH>(arg0, 9, b"WEMUSH", b"WAVE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ae9faf5-3ccc-4d58-b6c1-03bc0de0b857.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEMUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEMUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

