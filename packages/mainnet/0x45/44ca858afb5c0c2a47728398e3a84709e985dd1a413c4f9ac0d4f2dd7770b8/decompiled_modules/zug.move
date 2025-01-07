module 0x4544ca858afb5c0c2a47728398e3a84709e985dd1a413c4f9ac0d4f2dd7770b8::zug {
    struct ZUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUG>(arg0, 9, b"ZUG", b"Zero Utility Garbage", x"5a65726f205574696c697479204761726261676520f09f9791efb88f204e6f2074672c206e6f20636162616c2c206e6f2054776974746572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaAw8bCu2eswbNJrd5kc4Y4NtAuo6t7sADPp7xW8rAK8g")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZUG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

