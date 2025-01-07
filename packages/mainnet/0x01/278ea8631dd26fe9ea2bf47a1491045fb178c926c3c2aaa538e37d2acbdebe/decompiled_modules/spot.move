module 0x1278ea8631dd26fe9ea2bf47a1491045fb178c926c3c2aaa538e37d2acbdebe::spot {
    struct SPOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOT>(arg0, 9, b"SPOT", b"SPOT", b"LETs cook together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://atlas-content-cdn.pixelsquid.com/assets_v2/253/2532994044858995715/previews/G03-200x200.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPOT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOT>>(v2, @0x51bc74eda8ab48e3c07b1aaf855540f1d2f46b779a2d2577b2bc74a0e3257350);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

