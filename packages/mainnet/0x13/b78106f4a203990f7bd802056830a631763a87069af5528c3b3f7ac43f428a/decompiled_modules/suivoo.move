module 0x13b78106f4a203990f7bd802056830a631763a87069af5528c3b3f7ac43f428a::suivoo {
    struct SUIVOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVOO>(arg0, 6, b"SUIVOO", b"Suivoo Pokemon", b"Suivoo is Suivee's girlfriend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiag7swogjf6724yru7gqr3wuoofrkqhg5wr75nxbjxgpfsps5axcq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIVOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

