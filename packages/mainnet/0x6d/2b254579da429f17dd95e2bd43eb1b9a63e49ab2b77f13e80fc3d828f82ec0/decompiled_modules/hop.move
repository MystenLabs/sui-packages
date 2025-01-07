module 0x6d2b254579da429f17dd95e2bd43eb1b9a63e49ab2b77f13e80fc3d828f82ec0::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"Hop", b"Hop slowsui", b"When you just want to be a degen and buy your degen coins on hop.fun and the devs keep on delaying.... hop slow sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037930_6680bad735.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

