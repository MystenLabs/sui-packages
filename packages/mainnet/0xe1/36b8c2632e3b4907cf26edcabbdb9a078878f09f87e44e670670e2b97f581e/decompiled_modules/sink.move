module 0xe136b8c2632e3b4907cf26edcabbdb9a078878f09f87e44e670670e2b97f581e::sink {
    struct SINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINK>(arg0, 6, b"SINK", b"SINKBOWL", b"WELCOME TO SINK BOWL. WHEN TOILET MEET THE SINK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4v422fya6vvq7k3jk2s2mff5sobze46hlqki7xtjndpb3chcule")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

