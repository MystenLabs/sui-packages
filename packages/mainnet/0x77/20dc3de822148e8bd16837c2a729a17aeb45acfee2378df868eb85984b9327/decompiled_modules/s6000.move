module 0x7720dc3de822148e8bd16837c2a729a17aeb45acfee2378df868eb85984b9327::s6000 {
    struct S6000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S6000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S6000>(arg0, 6, b"S6000", b"SUI 6000", b"6,000 $SUI in the bonding curve is the goal. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9490_70c2ca53fd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S6000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S6000>>(v1);
    }

    // decompiled from Move bytecode v6
}

