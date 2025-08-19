module 0x4986a52e90ebd52871b3f3a8848f0f4106c54f781b2fd1ac76d7328bf649f2a9::bomi {
    struct BOMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMI>(arg0, 9, b"BOMI", b"BOME ON SUI", b"BOME ON SUI BOME ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOMI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMI>>(v2, @0x6e0a1ceb07a90728589cc3d3ccef9dfc59f2cd276140558ccbd859055f6a3ac5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

