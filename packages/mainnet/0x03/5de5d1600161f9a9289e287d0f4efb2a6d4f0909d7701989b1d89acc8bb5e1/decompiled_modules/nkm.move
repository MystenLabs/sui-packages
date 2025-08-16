module 0x35de5d1600161f9a9289e287d0f4efb2a6d4f0909d7701989b1d89acc8bb5e1::nkm {
    struct NKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKM>(arg0, 9, b"nkm", b"nakama", b"onepiece on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NKM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKM>>(v2, @0xcd9c278926a1b2b6fa92a5803eb630891088adc5ef8cce35e02aeba89f7f1b0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NKM>>(v1);
    }

    // decompiled from Move bytecode v6
}

