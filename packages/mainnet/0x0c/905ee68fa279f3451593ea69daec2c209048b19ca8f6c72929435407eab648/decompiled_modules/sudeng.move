module 0xc905ee68fa279f3451593ea69daec2c209048b19ca8f6c72929435407eab648::sudeng {
    struct SUDENG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUDENG>, arg1: 0x2::coin::Coin<SUDENG>) {
        0x2::coin::burn<SUDENG>(arg0, arg1);
    }

    fun init(arg0: SUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDENG>(arg0, 9, b"hippo", b"sudeng", b"SuDeng is the cutest $HIPPO on SUI, bringing $HIPPO to the world of memes.  No cats, no dogs. Only $HIPPO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/DPQZIO3.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUDENG>>(v1);
        0x2::coin::mint_and_transfer<SUDENG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDENG>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUDENG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUDENG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

