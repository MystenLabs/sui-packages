module 0xc754ce4b59dd67cda6902ee6f88fe9ae3515da443dca09ded76bf16a6bb930a1::suigl {
    struct SUIGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGL>(arg0, 6, b"SUIGL", b"Suigull", x"53756967756c6c206f6e205375692e2053776f6f7020616e64206772616220746861742066697368210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo22_6e95628431_33c838fd02.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

