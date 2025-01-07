module 0xc2b92a37f13edc0a3be4acd86420c563783a6a5d86ed4415e1c60c8c2b6a1a40::goat_sui {
    struct GOAT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT_SUI>(arg0, 9, b"GOAT SUI", b"GOAT SUI", b"goat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOAT_SUI>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT_SUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

