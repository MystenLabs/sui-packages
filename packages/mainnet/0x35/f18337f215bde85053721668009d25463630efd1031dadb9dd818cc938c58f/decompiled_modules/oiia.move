module 0x35f18337f215bde85053721668009d25463630efd1031dadb9dd818cc938c58f::oiia {
    struct OIIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIIA>(arg0, 6, b"OIIA", b"Oiia Sui", b"Oiia Oiia cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib5zne27jbfj5fw5r4ckkhvdekwyeygsghie4s3mbudik6gmtpu3y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OIIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

