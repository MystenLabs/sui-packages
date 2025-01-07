module 0x5e2b34326f0495b7f6d3e76e51357ebfabf16b2337e8fca8fe13fe9cf782207a::dryvedryve {
    struct DRYVEDRYVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRYVEDRYVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRYVEDRYVE>(arg0, 9, b"DryveDryve", b"TESTDRYVE7", b"None", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRYVEDRYVE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRYVEDRYVE>>(v2, @0xf881462c5d698d1571b4ad234b9a697686f47772d3d01ed42232d7a43bee82c5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRYVEDRYVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

