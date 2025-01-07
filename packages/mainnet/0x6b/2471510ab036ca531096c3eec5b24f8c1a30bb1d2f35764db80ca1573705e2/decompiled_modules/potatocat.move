module 0x6b2471510ab036ca531096c3eec5b24f8c1a30bb1d2f35764db80ca1573705e2::potatocat {
    struct POTATOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTATOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTATOCAT>(arg0, 9, b"pCAT", b"Potato Cat", b"Potato Cat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POTATOCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTATOCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTATOCAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

