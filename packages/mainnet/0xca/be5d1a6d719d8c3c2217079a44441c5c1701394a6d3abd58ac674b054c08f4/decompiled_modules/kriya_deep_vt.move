module 0xcabe5d1a6d719d8c3c2217079a44441c5c1701394a6d3abd58ac674b054c08f4::kriya_deep_vt {
    struct KRIYA_DEEP_VT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_DEEP_VT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_DEEP_VT>(arg0, 6, b"KRIYA_DEEP_VT", b"KriyaCLMM-DEEP-AltChopper-VaultToken", b"Vault token representing 1 unit of ownership in Kriya's Auto-rebalancing and Auto-Compounding Strategy on top of Kriya CLMM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://arweave.net/2R1_8mQgn1ofjXxEwripdxrfQK1ldiWUsiKeX2DDb_A"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_DEEP_VT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_DEEP_VT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

