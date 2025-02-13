module 0xaa07dec4bc16e409ff311cc3577a45073909df2ec66199f11925dd30b4dbc049::wav {
    struct WAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAV>(arg0, 9, b"WAV", b"Wave", b"Telegram-based ecosystem for game and D-apps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://docs.waveonsui.com/~gitbook/image?url=https%3A%2F%2F1657324024-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252FO0OuE9apMynE1w94XSMA%252Fuploads%252FWCOuxEih6RSrc5Mhz1y4%252FWAVE.png%3Falt%3Dmedia%26token%3Dedf10de6-087d-429a-a8f1-bc4082aae9e8&width=768&dpr=1&quality=100&sign=eaa2fc22&sv=2")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAV>>(0x2::coin::mint<WAV>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAV>>(v2);
    }

    // decompiled from Move bytecode v6
}

