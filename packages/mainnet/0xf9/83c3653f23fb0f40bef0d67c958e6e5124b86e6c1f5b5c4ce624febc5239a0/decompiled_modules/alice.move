module 0xf983c3653f23fb0f40bef0d67c958e6e5124b86e6c1f5b5c4ce624febc5239a0::alice {
    struct ALICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALICE>(arg0, 6, b"ALICE", b"Alice Weidel", b"$ALICE token is a digital signature driving a new wave of leadership and progress. Backed by influential figures and fueled by a vision to Save Germany, $ALICE is more than just a token; its a movement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000143803_73000e3df9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

