module 0x10a5a6d6c1e489e7eea76f135e2321b95824ecf3705a3e5b7071c4a822158513::thegay {
    struct THEGAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEGAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEGAY>(arg0, 6, b"TheGay", b"TheGayverse", b"Eyes wide, bags light he clips first, asks never. GAYVERSE dies with him", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicveabrudu4fuczjjf5zukila7yqzt2k3c3bqr2gukatn65fqket4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEGAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THEGAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

