module 0xaf387d95985901819a5154f53d5bd9b65ea1f11a9f95302496c44d7659c6fc7b::gork {
    struct GORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORK>(arg0, 9, b"gork", b"New XAI gork", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXkHvTBRFMyY5ozYHXcF7JHqqLBTorca3dXAdF3ooD5e3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GORK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

