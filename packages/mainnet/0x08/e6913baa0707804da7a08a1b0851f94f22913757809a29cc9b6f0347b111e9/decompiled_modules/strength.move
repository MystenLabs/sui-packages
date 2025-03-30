module 0x8e6913baa0707804da7a08a1b0851f94f22913757809a29cc9b6f0347b111e9::strength {
    struct STRENGTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRENGTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRENGTH>(arg0, 6, b"STRENGTH", b"Super Strength", b"it's time for the super powers to take over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052289_10a06a4902.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRENGTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRENGTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

