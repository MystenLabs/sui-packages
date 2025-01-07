module 0xbbd760c2f224cd3a29f9d467862b5c607be9040bf1c16d8f1a7fe061379d1a6a::shsui {
    struct SHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHSUI>(arg0, 5, b"SHSUI", b"SeaHorse ", b"SeaHorse Sui was born a meme on the SUI ecosystem with the potential of a community on the sui ecosystem being extremely strong.Website: https://www.seahorseonsui.org X: https://twitter.com/SeaHorsesui Telegram: https://t.me/SeaHorse_Portal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.seahorseonsui.org/images/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHSUI>(&mut v2, 42000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

