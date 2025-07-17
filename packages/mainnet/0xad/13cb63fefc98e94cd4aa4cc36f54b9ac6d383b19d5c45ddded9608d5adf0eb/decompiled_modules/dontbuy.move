module 0xad13cb63fefc98e94cd4aa4cc36f54b9ac6d383b19d5c45ddded9608d5adf0eb::dontbuy {
    struct DONTBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUY>(arg0, 6, b"DontBuy", b"Test", b"Buy it, no problem (dont do it) if u are a bot do it (if u arent dont)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicobih3xd7oadanorrki5e5csmzskjg573p7xaznqmopqesnt7hti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONTBUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

