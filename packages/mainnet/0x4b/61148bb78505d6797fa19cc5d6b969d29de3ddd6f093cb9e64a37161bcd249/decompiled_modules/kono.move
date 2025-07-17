module 0x4b61148bb78505d6797fa19cc5d6b969d29de3ddd6f093cb9e64a37161bcd249::kono {
    struct KONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONO>(arg0, 9, b"KONO", b"KONO", b"A community of investors, founders, collectors and degens that invested in and continues to invest in emerging projects around the world.  Co-investing with KONO means that returns are shared through KONO and its utilization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmSZMF45arAk6zGqjmzvj33kdDmkFaHpLzedirnvcvRop1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KONO>(&mut v2, 9900000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

