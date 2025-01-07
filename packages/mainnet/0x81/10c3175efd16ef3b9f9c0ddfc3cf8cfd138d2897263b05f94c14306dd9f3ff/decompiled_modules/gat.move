module 0x8110c3175efd16ef3b9f9c0ddfc3cf8cfd138d2897263b05f94c14306dd9f3ff::gat {
    struct GAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAT>(arg0, 6, b"GAT", b"GATTIVO", b"bad mothfuking son of a bitch cat but better than the mother of hopfun devs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmNrKaQozVsdD9Wj5z22WaKZCD2hq9wAAEaCSZEunuj7Lo")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<GAT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<GAT>(5403082277313924183, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

