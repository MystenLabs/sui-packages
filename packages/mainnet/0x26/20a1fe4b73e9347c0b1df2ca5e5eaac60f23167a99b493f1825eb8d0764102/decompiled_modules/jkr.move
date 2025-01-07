module 0x2620a1fe4b73e9347c0b1df2ca5e5eaac60f23167a99b493f1825eb8d0764102::jkr {
    struct JKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKR>(arg0, 9, b"JKR", b"JOKER COIN", b"JOKER COIN is my meme coin for trading in wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68701415-be56-4147-8d54-4ab6887cb0c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

