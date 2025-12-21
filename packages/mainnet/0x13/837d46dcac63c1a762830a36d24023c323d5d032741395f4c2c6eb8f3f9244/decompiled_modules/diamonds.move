module 0x13837d46dcac63c1a762830a36d24023c323d5d032741395f4c2c6eb8f3f9244::diamonds {
    struct DIAMONDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMONDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMONDS>(arg0, 0, b"DIAMONDS", b"Lineup Games Diamonds", x"537461636b204469616d6f6e647320746f20626f6f737420796f757220736861726520e280942061206d6173736976652061697264726f70206973206f6e20746865207761792e20546865206d6f726520796f752073636f72652c20746865206d6f726520796f75206561726e2e20506c617920736d6172742c20636f6c6c65637420686172642c20616e642077696e206269672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lineupgames.myfilebase.com/ipfs/QmcPq9gV3TTrkjog6m53zqCQiSaXeWwXE2CvqKHp3h7ytb")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMONDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMONDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

