module 0x555c095f43c7bfd371f8b789040e3f24011ffbc449775e5f49e27d07c736dc42::pinko {
    struct PINKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKO>(arg0, 9, b"PINKO", b"Pinko", b"I HELD REDDO , DON'T WANT TO TAKE THE PROJECT NOW HE'S PINK , COMMUNITY LAUNCH , FAIR LAUNCH FOR ALL REDDO HOLDERS THAT GOT DUMPED ON .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmc4ujjBpm2K85ioREqQ7FcLds49iWqHzuE4uJcGcg8on5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINKO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

