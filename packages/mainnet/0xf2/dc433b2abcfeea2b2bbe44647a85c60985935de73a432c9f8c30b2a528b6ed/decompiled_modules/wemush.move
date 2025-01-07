module 0xf2dc433b2abcfeea2b2bbe44647a85c60985935de73a432c9f8c30b2a528b6ed::wemush {
    struct WEMUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEMUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEMUSH>(arg0, 9, b"WEMUSH", b"WAVE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb58683c-7de9-4e0c-8dfc-fcd13dadc4b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEMUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEMUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

