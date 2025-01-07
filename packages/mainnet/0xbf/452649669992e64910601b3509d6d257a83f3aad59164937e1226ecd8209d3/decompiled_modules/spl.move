module 0xbf452649669992e64910601b3509d6d257a83f3aad59164937e1226ecd8209d3::spl {
    struct SPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL>(arg0, 9, b"SPL", b"Pig Smile", b"Pig Smile meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73a141c3-d248-416a-8dbc-ded188a5d6b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

