module 0xc8ab9aa12f5b82897c9574a13790fcb56afe0a62d9ed4c5a6398377f009e232f::kappi {
    struct KAPPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPPI>(arg0, 9, b"KAPPI", b"KAPPI", b"KAPPI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.kappi.fun/_next/image?url=%2Flogo.jpg&w=2048&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAPPI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAPPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPPI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

