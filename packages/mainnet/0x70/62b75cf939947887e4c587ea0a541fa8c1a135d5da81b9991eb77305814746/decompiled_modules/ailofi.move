module 0x7062b75cf939947887e4c587ea0a541fa8c1a135d5da81b9991eb77305814746::ailofi {
    struct AILOFI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AILOFI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AILOFI>>(0x2::coin::mint<AILOFI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: AILOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AILOFI>(arg0, 9, b"AILOFI", b"AILOFI", b"A fully operating Ai Agent on a iconic meme, AILOFI is true degen shilling his meme in X also responding to everyone with a catchy yet funny phrase.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1860099958117896192/RIZWNf_O_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AILOFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AILOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AILOFI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

