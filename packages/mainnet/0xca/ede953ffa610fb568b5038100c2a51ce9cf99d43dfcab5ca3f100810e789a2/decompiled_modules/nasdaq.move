module 0xcaede953ffa610fb568b5038100c2a51ce9cf99d43dfcab5ca3f100810e789a2::nasdaq {
    struct NASDAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NASDAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NASDAQ>(arg0, 6, b"NASDAQ", b"NASDAQ - STOCK MARKET", b"THE COIN FOR THE INVESTORS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihijmwskxi3e4tlv22f7agbsfwurwdv5izpz2mxdko6tkd5efdmou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NASDAQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NASDAQ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

