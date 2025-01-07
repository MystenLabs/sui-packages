module 0x573c18c27cfecd3d7904222a4d5c7a1932afd0b6f21481be41c063d428cbdbaa::le {
    struct LE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LE>(arg0, 9, b"LE", b" Leonel Lo", b"Introducing Leonel Coin: the love-themed meme coin crafted by a man deeply in love with an elusive Elena. His dream is to reach her, and with your support, it could become reality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9bd7f57-13d4-4527-82ed-43051e9eeaf3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LE>>(v1);
    }

    // decompiled from Move bytecode v6
}

