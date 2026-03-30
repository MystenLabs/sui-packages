module 0x4a9e9a48eaf007db0eacbbddde724083d854b7a93c4608dd5d562e858070a088::yakuza {
    struct YAKUZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAKUZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAKUZA>(arg0, 6, b"YAKUZA", b"Yakuza Meme Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YAKUZA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAKUZA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YAKUZA>>(v2);
    }

    // decompiled from Move bytecode v6
}

