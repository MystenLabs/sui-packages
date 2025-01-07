module 0x82d39a6d5e09904abdf8576036afbd1de0dda67cccf90d26d2e7217d508ee195::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 9, b"NAMI", b"Suinami", b"Join The Wave!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://prnt.sc/89dtinIOf1mJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAMI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

