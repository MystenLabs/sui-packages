module 0x2d8b132bcb0c7c57479ce00b93ae118204b562c14227cf4d6e861e43c5038e54::pkl {
    struct PKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKL>(arg0, 9, b"PKL", b"High Displacement", b"Popular among enthusiasts for their speed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/pkl-logo-pkl-letter-pkl-letter-logo-design-initials-pkl-logo-linked-with-circle-uppercase-monogram-logo-pkl-typography-technology-business-real-estate-brand_229120-79923.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PKL>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

