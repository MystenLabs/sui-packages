module 0x228c3ad761311e756b67daa3e2e46f14aded400fd66e3007a18253c7d0aa0a55::trumpdoge {
    struct TRUMPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPDOGE>(arg0, 9, b"TRUMPDOGE", b"DRUMP", b"Introducing Trump Dogs Token: a fun meme coin blending the charisma of Donald Trump with our beloved pups! Join a playful community where humor meets crypto and unleash your investment potential while celebrating the bond between dogs and politics!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7413cd4d-8254-4721-a77c-6981ecf73372.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

