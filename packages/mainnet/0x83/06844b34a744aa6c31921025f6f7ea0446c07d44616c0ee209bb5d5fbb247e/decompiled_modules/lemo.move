module 0x8306844b34a744aa6c31921025f6f7ea0446c07d44616c0ee209bb5d5fbb247e::lemo {
    struct LEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMO>(arg0, 6, b"LEMO", b"LEMO on SUI", b"ENJOY THE #SUISUMMER WITH LEMO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeialcnvqyn63xfpqbles7um5jjtxrrkscqc55t2kpfcqprlrbah3aq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LEMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

