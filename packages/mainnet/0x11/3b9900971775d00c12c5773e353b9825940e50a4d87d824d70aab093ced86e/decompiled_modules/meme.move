module 0x113b9900971775d00c12c5773e353b9825940e50a4d87d824d70aab093ced86e::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"MEME", b"MemeMagic", b"MemeMagic is a fun and whimsical cryptocurrency designed to celebrate the viral nature of memes. Join the laughter and ride the wave of meme culture with us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a79c27e2-57c6-4fcb-92b1-f149768a84a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

