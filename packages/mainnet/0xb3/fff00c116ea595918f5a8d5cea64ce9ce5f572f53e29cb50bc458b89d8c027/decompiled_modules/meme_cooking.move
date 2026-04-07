module 0xb3fff00c116ea595918f5a8d5cea64ce9ce5f572f53e29cb50bc458b89d8c027::meme_cooking {
    struct MEME_COOKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_COOKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_COOKING>(arg0, 9, b"Meme Cooking", b"Meme Cooking", b"Meme shef year Of Shef is live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775602896097-612a03f5f324f82b50e49da0212db54e.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME_COOKING>>(0x2::coin::mint<MEME_COOKING>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_COOKING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_COOKING>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

