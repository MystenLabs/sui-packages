module 0xe59300ec3a1575bcf688b26055c7f46c5728c6a87cdadc85ae7090deed857703::mikami {
    struct MIKAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKAMI>(arg0, 9, b"Mikami", b"Mikami On Sui", b"Yua Mikami  the Queen of culture  now steps onto Solana. Get My official $Mikami now, Join my very special Mikami Community now! Beauty fades. Scarcity stays. Balance reigns. The future belongs to believers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmdu6ExwiioFY73Q3dJPMvf2DXXfvdh6sCfpmtebf6Hh1Z")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIKAMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKAMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKAMI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

