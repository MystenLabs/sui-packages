module 0x571609546c69f3035b6fa9247b101a900a96e468b083d74ddf705f6ecadce24::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 9, b"MELANIA", b"Melania Meme", b"Official MELANIA meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreiduq5c43xdbcbhzx3plcdtz2jwkjpzlm2hwkoxhjgmnmqbl6otyfu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MELANIA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

