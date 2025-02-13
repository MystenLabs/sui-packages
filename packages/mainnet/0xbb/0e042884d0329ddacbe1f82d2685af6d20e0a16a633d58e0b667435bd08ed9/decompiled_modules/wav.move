module 0xbb0e042884d0329ddacbe1f82d2685af6d20e0a16a633d58e0b667435bd08ed9::wav {
    struct WAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAV>(arg0, 9, b"WAV", b"Wave", b"Telegram-based ecosystem for game and D-apps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://docs.waveonsui.com/~gitbook/image?url=https%3A%2F%2F3118291702-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Forganizations%252F6ZLOd0kIyWd1xcqKDDsl%252Fsites%252Fsite_1NepZ%252Ficon%252FKEgo1nb8KpdTDpkJXuo5%252FWAVE_logo.png%3Falt%3Dmedia%26token%3D635150ba-4e00-4187-a415-1ef58eab1d21&width=32&dpr=1&quality=100&sign=8e895a91&sv=2")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAV>>(0x2::coin::mint<WAV>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAV>>(v2);
    }

    // decompiled from Move bytecode v6
}

