module 0x7a27a8f9f3e0f7186572982cd6e9a34a559e2cf1157d613c0c7df8f92f0ae7a2::bv2 {
    struct BV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BV2>(arg0, 6, b"BV2", b"BOREDV2", b"Bored v2 launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibrznbpqxf34im4ua7ilevq23bnrfp7kf5svyxfoyj3soxxnu75uq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BV2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BV2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

