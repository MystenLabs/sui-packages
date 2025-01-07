module 0x72be8aa793e36dad8ba9b862a09d5a5bcdc05db51cffe0d124d7a0b46394dc54::squidgame {
    struct SQUIDGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDGAME>(arg0, 9, b"SQUIDGAME", b"SQUIDGAME On SUI", x"54686520474f415420636f6d656261636b206973206261636b206f6e20746865206772696e64212047657420696e206f722067657420575245434b45442c206e6f206361702e204e6f77e2809973207468652074696d6520746f2061706520696e20616e64207269646520746865207761766521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQNxdRDtoxtfpdB4FhWKooPYE87fT6kUtN73C3JUDQ9rj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUIDGAME>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIDGAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDGAME>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

