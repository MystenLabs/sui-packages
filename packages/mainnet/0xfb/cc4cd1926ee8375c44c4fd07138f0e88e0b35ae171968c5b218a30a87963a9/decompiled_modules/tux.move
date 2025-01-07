module 0xfbcc4cd1926ee8375c44c4fd07138f0e88e0b35ae171968c5b218a30a87963a9::tux {
    struct TUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUX>(arg0, 9, b"TUX", b"Tux The Penguin", b"Are you ready for a dose of cuteness in your crypto journey? Meet Tux, the charming penguin from the Arctic, waddling his way to the Sui Blockchain! Join us as Tux brings a wave of cheer and excitement, making Sui the talk of the town. Dive in and experience the fun with Tux today!  Website: https://suipenguin.fun/ Twitter: https://x.com/SuiPenguinTux Telegram: https://t.me/SuiPenguinOfficial", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/9u79Ahf.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

