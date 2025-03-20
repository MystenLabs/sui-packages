module 0x19f8aed87659fa23094c4a3f2c76da832ad0ee26b611fddafdeb74e72aaf81af::fmcs {
    struct FMCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMCS>(arg0, 9, b"FMCS", b"FMCS on Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXxCSTdom8hXfFFnzn3PBc4137YYsUBtZEnm3aMwtSofw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FMCS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FMCS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMCS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

