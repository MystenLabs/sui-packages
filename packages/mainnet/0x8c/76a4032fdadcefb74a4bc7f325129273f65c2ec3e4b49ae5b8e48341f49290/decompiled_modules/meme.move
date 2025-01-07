module 0x8c76a4032fdadcefb74a4bc7f325129273f65c2ec3e4b49ae5b8e48341f49290::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"MEME", b"MemeMagic", b"MemeMagic is a fun and whimsical cryptocurrency designed to celebrate the viral nature of memes. Join the laughter and ride the wave of meme culture with us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96ced4a6-a397-4f4b-9031-0bef0833e870.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

