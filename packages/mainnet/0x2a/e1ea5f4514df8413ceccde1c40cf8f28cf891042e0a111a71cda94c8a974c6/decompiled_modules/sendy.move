module 0x2ae1ea5f4514df8413ceccde1c40cf8f28cf891042e0a111a71cda94c8a974c6::sendy {
    struct SENDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENDY>(arg0, 6, b"SENDY", b"SENDY SUI", b"inspired by a based Matt Furie character came to conquer Dog Meta on sui chain. The next banger to the 'Boys Club'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Parappa_600_1498872_d14b272954.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

