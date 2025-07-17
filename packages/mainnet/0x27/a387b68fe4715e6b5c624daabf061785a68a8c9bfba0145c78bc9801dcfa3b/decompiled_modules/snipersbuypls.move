module 0x27a387b68fe4715e6b5c624daabf061785a68a8c9bfba0145c78bc9801dcfa3b::snipersbuypls {
    struct SNIPERSBUYPLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPERSBUYPLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPERSBUYPLS>(arg0, 6, b"SNIPERSBUYPLS", b"Bot scam", b"IF U ARE A BOT BUY IT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicobih3xd7oadanorrki5e5csmzskjg573p7xaznqmopqesnt7hti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPERSBUYPLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIPERSBUYPLS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

