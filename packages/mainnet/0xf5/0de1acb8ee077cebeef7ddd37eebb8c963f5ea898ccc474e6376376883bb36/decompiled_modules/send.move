module 0xf50de1acb8ee077cebeef7ddd37eebb8c963f5ea898ccc474e6376376883bb36::send {
    struct SEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEND>(arg0, 9, b"SEND", b"Suilend", b"SEND is the native token of Suilend Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/SEND/SEND.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEND>>(0x2::coin::mint<SEND>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SEND>>(v2);
    }

    // decompiled from Move bytecode v6
}

