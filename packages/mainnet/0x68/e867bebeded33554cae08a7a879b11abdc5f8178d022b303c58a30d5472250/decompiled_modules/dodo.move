module 0x68e867bebeded33554cae08a7a879b11abdc5f8178d022b303c58a30d5472250::dodo {
    struct DODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODO>(arg0, 6, b"DODO", b"Dodo Sui", b"YOU NEED DODO IN YOUR WALLET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreierqp7g5ygc7qvpx7lc56beqledq3g7j5lrq24vmbazkth5wveija")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DODO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

