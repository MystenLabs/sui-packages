module 0xa2e3381b544fd802d6e185ec8bb7fa6ad535a13a449b044bf286abfb20022c33::popfrog {
    struct POPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPFROG>(arg0, 6, b"POPFROG", b"POPFROG SUI", x"46524f47205448415420504f505320200a504f50434154205245414348454420312042494c4c494f4e20200a504f5046524f4720495320434f4d494e4720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_Xdr_K_Lny_400x400_0cd30559cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

