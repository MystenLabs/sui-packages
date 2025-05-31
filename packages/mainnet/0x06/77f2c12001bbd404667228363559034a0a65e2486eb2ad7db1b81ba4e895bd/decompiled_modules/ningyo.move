module 0x677f2c12001bbd404667228363559034a0a65e2486eb2ad7db1b81ba4e895bd::ningyo {
    struct NINGYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINGYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINGYO>(arg0, 6, b"NINGYO", b"Ningyo Fish", b"The Richest fsh on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih6svqm4unt2kydpahipk7bqqf6mzopexq7s2prfkpkm2gkopeuye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINGYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NINGYO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

