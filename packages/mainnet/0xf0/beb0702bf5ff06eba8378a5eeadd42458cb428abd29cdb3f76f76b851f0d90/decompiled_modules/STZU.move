module 0xf0beb0702bf5ff06eba8378a5eeadd42458cb428abd29cdb3f76f76b851f0d90::STZU {
    struct STZU has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STZU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STZU>>(0x2::coin::mint<STZU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STZU>(arg0, 9, b"STZU", b"Sui Tzu", b"Sui Tzu is a new-age meme-coin created to celebrate our fluffiest dogs and initiate a new wave of funny dog memes on the internet, this time with the lovable Sui Tzu!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/1fCdWxCC/5-1.png"))), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STZU>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STZU>>(v2);
    }

    // decompiled from Move bytecode v6
}

