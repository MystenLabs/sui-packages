module 0xbada8947ecb016a45bbb2b8694aaf98800ae095b8437f82feb8a7a08a8c3c542::slub {
    struct SLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUB>(arg0, 6, b"SLUB", b"SLUB SUI", x"617274206279200a407675746e657261626c650a2024534c5542", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgp3qlhf5oth5sa7tdx4frugsw522n4p6bq33edcaxzd3b7v65pi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

