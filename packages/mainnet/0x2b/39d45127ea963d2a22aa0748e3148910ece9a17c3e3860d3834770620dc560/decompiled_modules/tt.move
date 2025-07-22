module 0x2b39d45127ea963d2a22aa0748e3148910ece9a17c3e3860d3834770620dc560::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 6, b"TT", b"test", b"sdgsgsg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidmxgsjjdcdynjmmdyh35cllay4sbdk22z3d2qtm24eqxxuhgjm7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

