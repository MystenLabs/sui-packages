module 0xc616149607e403d2f19b1489c438d473979963c1c4d0dd4233c790d31f1e7e9d::riolu {
    struct RIOLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIOLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIOLU>(arg0, 6, b"RIOLU", b"Riolu Pokemon Battle", b"$RIOLU is the first pokemon battle game on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieksd6preqhhevrwvi6qczymqtbrrzndwtqsigix7gabh4uzjcc4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIOLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIOLU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

