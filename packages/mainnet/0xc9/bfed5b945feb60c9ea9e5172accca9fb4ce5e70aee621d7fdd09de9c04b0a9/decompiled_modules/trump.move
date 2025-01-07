module 0xc9bfed5b945feb60c9ea9e5172accca9fb4ce5e70aee621d7fdd09de9c04b0a9::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"Trump Coin", b"Trump Coin is a cryptocurrency inspired by former U.S. President Donald Trump, primarily serving as a \"meme coin\" that reflects support for his values and political stance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a69d1d45-4c0f-4189-9861-e7f6097bd551.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

