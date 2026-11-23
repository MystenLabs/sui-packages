module 0x2e951671dee01c92dd5a6b75d7c20b4d04220d4f3a617ea8a908c47a57ea6125::pentq {
    struct PENTQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENTQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENTQ>(arg0, 9, b"PENTQ", b"Penguin Chat", b"Penguin Chat is a culture-forward meme token channeling monkey mischief for YouTube shorts, tipping, and quick raids.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmSKB8ofWRzS49DVZBVVXNoZ4n6ydRNtGP4PqXHSZTJ6Yr")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PENTQ>>(0x2::coin::mint<PENTQ>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENTQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENTQ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

