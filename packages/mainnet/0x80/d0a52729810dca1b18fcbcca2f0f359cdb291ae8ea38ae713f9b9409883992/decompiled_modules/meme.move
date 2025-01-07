module 0x80d0a52729810dca1b18fcbcca2f0f359cdb291ae8ea38ae713f9b9409883992::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<MEME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME>>(0x2::coin::split<MEME>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<MEME>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MEME>(arg0);
        };
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"Octopus", b"Octopus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media-cdn-v2.laodong.vn/storage/newsportal/2024/10/11/1406466/Diddy-2.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME>>(0x2::coin::mint<MEME>(&mut v2, 8181054663000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

