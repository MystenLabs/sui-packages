module 0x4790bad0854ada98d61d64cb9993898953b6a730529620fb3fcd5a926ebf2d9b::h2o {
    struct H2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: H2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H2O>(arg0, 6, b"H2O", b"H2O SUI", b"H2O is the molecule that supports life, now on the blockchain. Elegant in its simplicity, H2O embodies purity and the essence of value. Step into the H2O universe and experience the core of crypto. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H2_O_TOKEN_7ddb2d784a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H2O>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H2O>>(v1);
    }

    // decompiled from Move bytecode v6
}

