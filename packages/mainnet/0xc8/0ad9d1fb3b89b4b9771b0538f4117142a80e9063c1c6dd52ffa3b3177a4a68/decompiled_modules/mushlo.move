module 0xc80ad9d1fb3b89b4b9771b0538f4117142a80e9063c1c6dd52ffa3b3177a4a68::mushlo {
    struct MUSHLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHLO>(arg0, 9, b"MUSHLO", b"WAVE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df49c789-8c9b-4d21-8206-13737f108415.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSHLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

