module 0xae87b8e4e4103e8691c7e79ba1ad9cc84bc323ed17f70fd700089caf87f277c0::asaadasdas {
    struct ASAADASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASAADASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASAADASDAS>(arg0, 6, b"AsAadasdas", b"sdasdasdasd", b"sadasdsadas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiausiabi6ej4ftvikttwijpjk4p5uyikm2dinhnh3dbemhgcjxuim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASAADASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASAADASDAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

