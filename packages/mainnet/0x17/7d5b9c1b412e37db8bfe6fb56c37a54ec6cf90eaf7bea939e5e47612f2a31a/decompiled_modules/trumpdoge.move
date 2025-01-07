module 0x177d5b9c1b412e37db8bfe6fb56c37a54ec6cf90eaf7bea939e5e47612f2a31a::trumpdoge {
    struct TRUMPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPDOGE>(arg0, 9, b"TRUMPDOGE", b"DRUMP", b"Introducing Trump Dogs Token: a fun meme coin blending the charisma of Donald Trump with our beloved pups! Join a playful community where humor meets crypto and unleash your investment potential while celebrating the bond between dogs and politics!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc8479b3-2643-47b4-a8cc-2f946f40e623.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

