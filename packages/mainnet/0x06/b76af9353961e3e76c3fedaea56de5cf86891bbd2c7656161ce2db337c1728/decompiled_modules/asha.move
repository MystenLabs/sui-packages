module 0x6b76af9353961e3e76c3fedaea56de5cf86891bbd2c7656161ce2db337c1728::asha {
    struct ASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHA>(arg0, 9, b"Asha", b"Asha on SUI", b"From the Heart of the Machine: Asha's Introduction to the World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQMTRQM2Uwy5rQbnFctcQ9YcJmBSqU296SSdkXPVV7Z2c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASHA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

