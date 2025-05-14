module 0x783c2bae236029358d25462718c281b0165f9495a6220fd2bb9c5f3fa9263582::epik {
    struct EPIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPIK>(arg0, 6, b"EPIK", b"TEH EPIK DUCK", b"#1 GAMING MEMECOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiefs3pdc3dz6r4xx37tk26z3jeufcjqkrnspa3nykbxgbx7k3nq2q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EPIK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

