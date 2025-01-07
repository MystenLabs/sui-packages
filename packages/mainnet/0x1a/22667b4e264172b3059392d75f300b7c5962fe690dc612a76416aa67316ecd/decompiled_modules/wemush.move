module 0x1a22667b4e264172b3059392d75f300b7c5962fe690dc612a76416aa67316ecd::wemush {
    struct WEMUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEMUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEMUSH>(arg0, 9, b"WEMUSH", b"MUSHLO", b"MUSHLO is a meme inspired by the spirit of adventure and freedom. With MUSHLO, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cfef614b-adfc-41b6-8225-44eed25524a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEMUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEMUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

