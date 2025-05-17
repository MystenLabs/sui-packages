module 0xa3e04c1653e747ec61f5da47f9051d3082f269ffbc9b70262677c0482a93b66e::shremp {
    struct SHREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREMP>(arg0, 6, b"SHREMP", b"SHREMP SUI", b"SHREMP live now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicgo6mty3dhimbphhtdgqkus65auks6ecchs4y4s5d47jr4lq4i7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHREMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

