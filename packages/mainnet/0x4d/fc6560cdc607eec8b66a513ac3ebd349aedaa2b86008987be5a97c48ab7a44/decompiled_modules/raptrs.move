module 0x4dfc6560cdc607eec8b66a513ac3ebd349aedaa2b86008987be5a97c48ab7a44::raptrs {
    struct RAPTRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPTRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAPTRS>(arg0, 6, b"RAPTRS", b"RaptrsSui", b"$Raptrs Believe in something.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicgwwwgaf4sdmoo744smh2gy2xxrtuugms4ccvme7ayuxquqwb4j4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPTRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAPTRS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

