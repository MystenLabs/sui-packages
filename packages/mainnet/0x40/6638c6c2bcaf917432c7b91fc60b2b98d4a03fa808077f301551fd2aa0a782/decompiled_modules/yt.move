module 0x406638c6c2bcaf917432c7b91fc60b2b98d4a03fa808077f301551fd2aa0a782::yt {
    struct YT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YT>(arg0, 9, b"YT", b"Yield-Token", b"Yield-Token wich aims to archieve profit trough allocated yields from liquididty positions and lending positions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmR5JU9f5Ta64si3Mzq54wwiQexJfi8CHHFNU4NdDSrj6V")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YT>>(v1);
    }

    // decompiled from Move bytecode v6
}

