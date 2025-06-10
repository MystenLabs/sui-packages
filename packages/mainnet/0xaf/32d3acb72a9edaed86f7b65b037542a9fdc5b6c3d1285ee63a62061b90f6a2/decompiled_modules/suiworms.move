module 0xaf32d3acb72a9edaed86f7b65b037542a9fdc5b6c3d1285ee63a62061b90f6a2::suiworms {
    struct SUIWORMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWORMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWORMS>(arg0, 6, b"SUIWORMS", b"Worms On Sui", b"The most electric memecoin on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigg2kurqx73s2t3fpfunltkdbe4orzj2a4wpiai7xkjpfpk5ae35e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWORMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWORMS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

