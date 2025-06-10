module 0xe7524faa0b16022c9864f5ffbb299ddb196440b1d182d712877f6399b16060ce::sdf {
    struct SDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDF>(arg0, 6, b"SDF", b"dsdsd", b"ihohi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiez43lssgngn4aheerwio56a7v2mir224jzqypk7lptdbjqgfzsu4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

