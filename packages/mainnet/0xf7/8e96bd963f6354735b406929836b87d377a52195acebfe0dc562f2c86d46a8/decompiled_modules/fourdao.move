module 0xf78e96bd963f6354735b406929836b87d377a52195acebfe0dc562f2c86d46a8::fourdao {
    struct FOURDAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOURDAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOURDAO>(arg0, 9, b"FOURDAO", b"4DAO", b"CZ DAO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/b92b2390-d983-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOURDAO>>(v1);
        0x2::coin::mint_and_transfer<FOURDAO>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOURDAO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

