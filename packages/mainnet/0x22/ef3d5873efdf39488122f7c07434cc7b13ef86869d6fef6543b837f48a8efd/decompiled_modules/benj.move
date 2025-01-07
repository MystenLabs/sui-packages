module 0x22ef3d5873efdf39488122f7c07434cc7b13ef86869d6fef6543b837f48a8efd::benj {
    struct BENJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENJ>(arg0, 6, b"BenJ", b"Benjamine", b"Happy Hour at    for those in Seoul. 6pm-10pm happening now. Come thru. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/224_94375a0118.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

