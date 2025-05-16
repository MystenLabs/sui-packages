module 0xa6d16671a6a5380b9bbe4cfed6af0aba11eee72a29e107095639eee75e3c3356::bwlub {
    struct BWLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWLUB>(arg0, 6, b"BWLUB", b"Bwlub On Sui", b"Dwistinguished $BWLUB fish, cwonnoisseur of fwine dinning and qwestionable life choice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidekd6x6o5xxxfooia2jjmxvjtjkeyhfhuc7fzajhwzkerwdpdewu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BWLUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

