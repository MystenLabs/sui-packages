module 0x5a46ec2817c32e6e4a3bee825934ddc601cdfe3cd1b3ec0fdd377bc0bbb75ce3::pinkguin {
    struct PINKGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKGUIN>(arg0, 6, b"PINKGUIN", b"PINK PENGU", b"PINKGUIN is The only cryptocurrency you will HODL till the next bear run.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5yeyl6m5tk3e3l7aeufzj5uhwhjappf2vtgmwvuoqwsrixdzwyy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PINKGUIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

