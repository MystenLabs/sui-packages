module 0x37ab6bba35cdfbe0a7740fc3f021fc405985b113af01c4b84f2ef1f211a0c274::dogboots {
    struct DOGBOOTS has drop {
        dummy_field: bool,
    }

    fun icon_url() : 0x1::option::Option<0x2::url::Url> {
        0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dogboots.xyz")))
    }

    fun init(arg0: DOGBOOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGBOOTS>(arg0, 0, b"DOGBOOTS", b"DOGBOOTS", b"Dog with Boots Meme Coin", icon_url(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGBOOTS>>(0x2::coin::mint<DOGBOOTS>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGBOOTS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGBOOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

