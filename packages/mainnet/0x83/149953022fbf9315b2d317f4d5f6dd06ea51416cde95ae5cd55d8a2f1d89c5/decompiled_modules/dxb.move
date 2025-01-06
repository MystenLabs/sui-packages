module 0x83149953022fbf9315b2d317f4d5f6dd06ea51416cde95ae5cd55d8a2f1d89c5::dxb {
    struct DXB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXB>(arg0, 9, b"DXB", b"DXB", b"DXBB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DXB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DXB>>(v1);
    }

    // decompiled from Move bytecode v6
}

