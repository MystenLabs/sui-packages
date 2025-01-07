module 0xab46532847e0f23fd6af7046aed44e0463f001397d334c7d6e3e8dbc36155a35::sgie {
    struct SGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGIE>(arg0, 9, b"SGIE", b"Sir Giggle", b"Sir Gigglesnort a meme cuilture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a54d3e83-2de1-4a60-a5a8-3f30fe731b40.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

