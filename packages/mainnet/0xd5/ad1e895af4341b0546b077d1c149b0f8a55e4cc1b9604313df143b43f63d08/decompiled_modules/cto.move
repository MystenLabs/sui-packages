module 0xd5ad1e895af4341b0546b077d1c149b0f8a55e4cc1b9604313df143b43f63d08::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"Chief Troll Officer", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://c.ndtvimg.com/2023-07/9n3che8_elon-musk_625x300_13_July_23.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CTO>(&mut v2, 420420421000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

