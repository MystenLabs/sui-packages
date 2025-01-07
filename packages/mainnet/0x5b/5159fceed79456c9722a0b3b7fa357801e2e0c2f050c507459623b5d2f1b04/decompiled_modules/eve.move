module 0x5b5159fceed79456c9722a0b3b7fa357801e2e0c2f050c507459623b5d2f1b04::eve {
    struct EVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVE>(arg0, 6, b"EVE", b"First woman on earth", b"EVEOnSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EVE_6bd2238223.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

