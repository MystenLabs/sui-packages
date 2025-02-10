module 0xf16fc39d6577ef987f086f853186dff1066c7618c4175c1a98b4e690145d64ca::res {
    struct RES has drop {
        dummy_field: bool,
    }

    fun init(arg0: RES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RES>(arg0, 9, b"RES", b"Republic of El Salvador Meme", b"The official meme of the Republic of El Salvador.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmP5bzKAyGbrYNoqo1v4Rg6WHjvvnaNVy651g9PBmTU6zG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

