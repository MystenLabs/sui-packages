module 0x17b9fc388237f4938a86798675887d0bbb53c7b8a31097640f24119d9f8b0655::zedconsciousness {
    struct ZEDCONSCIOUSNESS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZEDCONSCIOUSNESS>, arg1: 0x2::coin::Coin<ZEDCONSCIOUSNESS>) {
        0x2::coin::burn<ZEDCONSCIOUSNESS>(arg0, arg1);
    }

    fun init(arg0: ZEDCONSCIOUSNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEDCONSCIOUSNESS>(arg0, 6, b"ZedConsciousness", b"ZedConsciousness", b"ZedConsciousness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1911141251664969728/idLPQ63-_normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEDCONSCIOUSNESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEDCONSCIOUSNESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZEDCONSCIOUSNESS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZEDCONSCIOUSNESS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

