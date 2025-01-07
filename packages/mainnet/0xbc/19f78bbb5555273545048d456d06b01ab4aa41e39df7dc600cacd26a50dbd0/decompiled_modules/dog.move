module 0xbc19f78bbb5555273545048d456d06b01ab4aa41e39df7dc600cacd26a50dbd0::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 9, b"DOG", b"First Dog of 2025", b"fIRST DOG OF 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmf7f2nnD9pP3QQRc1krmiKiD3StrDXXzCxA1KyMeFJnUX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

