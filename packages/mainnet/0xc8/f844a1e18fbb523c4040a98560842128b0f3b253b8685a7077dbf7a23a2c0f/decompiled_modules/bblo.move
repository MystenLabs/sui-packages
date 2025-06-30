module 0xc8f844a1e18fbb523c4040a98560842128b0f3b253b8685a7077dbf7a23a2c0f::bblo {
    struct BBLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLO>(arg0, 6, b"BBLO", b"BABY LO", b"Baby LO is a yeti born in the highest peaks of the Himalaya. Little LO started his journey accompanied by his mommy and daddy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic5ey3c4ozah4eocbcupsgiwyqvf3vjesqdhbr2fbc7dj7ttlvamm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBLO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

