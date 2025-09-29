module 0x95ff594811b4bd6374e260831cec26ba5283bf3bdc0d520af8667359518e9f2a::def {
    struct DEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEF>(arg0, 6, b"Def", b"Deforgs", b"Just art", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicas2re262ozr5ynnb4xowzb2xyccifjae6ayelo5qzec52324b3y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

