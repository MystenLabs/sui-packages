module 0x8d7828432b668f731d3ceb17f7fb9cad7225bf01b6af16e61b71b02384f9f291::babyscb {
    struct BABYSCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSCB>(arg0, 3, b"BABYSCB", b"Baby Sacabam", b"Baby Sacabam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JRgDf2e.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<BABYSCB>(&mut v2, 470000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSCB>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

