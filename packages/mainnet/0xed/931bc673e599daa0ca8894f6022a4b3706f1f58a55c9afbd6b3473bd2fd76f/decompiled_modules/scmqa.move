module 0xed931bc673e599daa0ca8894f6022a4b3706f1f58a55c9afbd6b3473bd2fd76f::scmqa {
    struct SCMQA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCMQA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCMQA>(arg0, 9, b"SCMQA", b"SolCreate Sui Media QA", b"Mainnet evidence for Sui creation-time token imagery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://scanner-backend.solcreate.app/media/image-9973524d813784cdfeba28f3cb97264faee068429c68b3ce815c4a77f73fb593.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SCMQA>>(0x2::coin::mint<SCMQA>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SCMQA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCMQA>>(v1);
    }

    // decompiled from Move bytecode v7
}

