module 0xc61a432f378e0c0f74492c63624cf6b9f1400e68938eb342e4f555a78748295e::process {
    struct PROCESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROCESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROCESS>(arg0, 6, b"PROCESS", b"${process.env}", b"${process.env} ${process.env} ${process.env}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifp6ekxoy4jflbld62sej7vmkke4fh6ea6w5w53n4mev7udxeaoy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROCESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PROCESS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

