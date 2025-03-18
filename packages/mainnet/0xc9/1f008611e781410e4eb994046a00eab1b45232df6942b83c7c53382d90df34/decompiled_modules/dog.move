module 0xc91f008611e781410e4eb994046a00eab1b45232df6942b83c7c53382d90df34::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"DogCoin by SuiAI", b"DogCoin is a meme cryptocurrency inspired by our beloved furry companions. Join the DogCoin community and let's bark our way to the moon! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/Li6Ssc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

