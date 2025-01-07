module 0xe188711df56693eb18b96963d6123ab15ab54791c774bc807e925da5dfb6b6b9::luck {
    struct LUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCK>(arg0, 9, b"LUCK", b"LUCK", b"GOOD LUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.textstudio.com/output/graphic/preview/large/7/9/0/7/7097_654b9268.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUCK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

