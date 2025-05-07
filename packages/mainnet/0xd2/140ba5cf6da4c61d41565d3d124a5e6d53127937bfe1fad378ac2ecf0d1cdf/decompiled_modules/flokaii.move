module 0xd2140ba5cf6da4c61d41565d3d124a5e6d53127937bfe1fad378ac2ecf0d1cdf::flokaii {
    struct FLOKAII has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKAII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKAII>(arg0, 6, b"FLOKAII", b"FLOKAI", x"5468652053746f7279204f662023466c6f6b6169200a0a54686520736d6172742062726f74686572206f662023466c6f6b692c20706f776572656420627920696e74656c6c6967656e636520616e6420726561647920746f20636f6e717565722074686520426c6f636b636861696e202353554920210a0a5768656e2023466c6f6b69206765747320736d61727465722c20466c6f6b616920656e746572732074686520667574757265206f662063727970746f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieut5fd5u4wb7essem46gw7dwdewdc7ux2lu3oiehervc2mifhyoq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKAII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLOKAII>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

