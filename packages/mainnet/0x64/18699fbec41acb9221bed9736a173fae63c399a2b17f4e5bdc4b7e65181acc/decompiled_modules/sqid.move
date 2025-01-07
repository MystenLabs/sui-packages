module 0x6418699fbec41acb9221bed9736a173fae63c399a2b17f4e5bdc4b7e65181acc::sqid {
    struct SQID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQID>(arg0, 6, b"SQID", b"SQUID on sui", b" Master the SUI markets with SQUID-cision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_30_23_28_49_a108618800.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQID>>(v1);
    }

    // decompiled from Move bytecode v6
}

