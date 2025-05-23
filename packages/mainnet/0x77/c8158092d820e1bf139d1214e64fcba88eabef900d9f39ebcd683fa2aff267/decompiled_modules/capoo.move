module 0x77c8158092d820e1bf139d1214e64fcba88eabef900d9f39ebcd683fa2aff267::capoo {
    struct CAPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPOO>(arg0, 6, b"CAPOO", b"BugCat Capoo", b"Meet CAPOO, BugCat Capoo looks like a cat or bug also has six feet and loves meat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiadb737ugigbx7ykcwiawi3tlamu6naeblu6bdwpd5uldtiod4uym")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAPOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

