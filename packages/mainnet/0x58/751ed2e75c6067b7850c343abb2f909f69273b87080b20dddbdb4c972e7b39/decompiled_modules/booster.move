module 0x58751ed2e75c6067b7850c343abb2f909f69273b87080b20dddbdb4c972e7b39::booster {
    struct BOOSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOSTER>(arg0, 6, b"BOOSTER", b"SUI BOOSTER", b"We take care of you, So you can take care of your community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicu6fwu53yfrrivh2vsjihki4xlo2fgmfzwlzauen3j2divaggkcq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOSTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

