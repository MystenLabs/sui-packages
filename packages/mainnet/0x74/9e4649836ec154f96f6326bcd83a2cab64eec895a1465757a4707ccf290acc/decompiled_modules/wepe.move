module 0x749e4649836ec154f96f6326bcd83a2cab64eec895a1465757a4707ccf290acc::wepe {
    struct WEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEPE>(arg0, 6, b"WEPE", b"Wall Street Pepe", b"Do it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif6hseyh3lb5cjpmsrswg2lcrdmrw3bwaplg3qkrof7iwnsrou47m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WEPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

