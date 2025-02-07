module 0xfa82bbaf39537bd4eda31b46b2ce9e8d5a671ad17106cdcba48e6e443da5adb9::btw {
    struct BTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTW>(arg0, 9, b"BTW", b"Back To Work", b"back to work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfYTfoFBYNvHcgtB5ZCD2Pp8ZcsMpjpkAYjg5ycn3fqSm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

