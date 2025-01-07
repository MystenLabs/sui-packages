module 0x866979fa335f2f4364668ebdd762875f6bf2f933f919eaeb650466dab882787::haifin {
    struct HAIFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIFIN>(arg0, 6, b"Haifin", b"Hal Finney", b"New launch. Hal Finney, the first one to run a Bitcoin node, the first miner, and the recipient of the very first Bitcoin transaction. 17k. Be safe with entries. Good ticker and branding. Has clog left so be aware. Degen. Always do your own research. Disclaimer ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_0ed6316774.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAIFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

