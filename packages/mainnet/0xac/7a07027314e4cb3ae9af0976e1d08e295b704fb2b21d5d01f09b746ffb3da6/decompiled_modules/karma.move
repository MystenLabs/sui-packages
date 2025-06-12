module 0xac7a07027314e4cb3ae9af0976e1d08e295b704fb2b21d5d01f09b746ffb3da6::karma {
    struct KARMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARMA>(arg0, 6, b"KARMA", b"Karma on Sui", b"be aware of the world's karma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaztxppjgxb5blmtpqf6wyoziboqwdhlpplp2szkjmicfueppmppy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KARMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

