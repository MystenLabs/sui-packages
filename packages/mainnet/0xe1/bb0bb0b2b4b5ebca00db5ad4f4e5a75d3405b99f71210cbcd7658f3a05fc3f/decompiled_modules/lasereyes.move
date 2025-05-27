module 0xe1bb0bb0b2b4b5ebca00db5ad4f4e5a75d3405b99f71210cbcd7658f3a05fc3f::lasereyes {
    struct LASEREYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASEREYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASEREYES>(arg0, 6, b"LASEREYES", b"SUI LASER EYES", b"Change your PFP to SUI LASER EYES!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidqleeaivgsv6huqrecgin36bkxqlavxem5727v5pcsfeb3ejusau")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASEREYES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LASEREYES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

