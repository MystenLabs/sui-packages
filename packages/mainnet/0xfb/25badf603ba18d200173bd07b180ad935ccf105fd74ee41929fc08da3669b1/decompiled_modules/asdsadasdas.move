module 0xfb25badf603ba18d200173bd07b180ad935ccf105fd74ee41929fc08da3669b1::asdsadasdas {
    struct ASDSADASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDSADASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDSADASDAS>(arg0, 6, b"Asdsadasdas", b"asdadsa", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiausiabi6ej4ftvikttwijpjk4p5uyikm2dinhnh3dbemhgcjxuim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDSADASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASDSADASDAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

