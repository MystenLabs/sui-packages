module 0x53db1f1c2f769a6a729a65bae54a453655a7da1bc86f0ea4b5b2943b5ebc3085::addict {
    struct ADDICT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDICT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ADDICT>(arg0, 6, b"ADDICT", b"Addict Agent by SuiAI", b"AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. .Constantly evolving and building. Join or eat dirt, lad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/999999999_0657777f6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADDICT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDICT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

