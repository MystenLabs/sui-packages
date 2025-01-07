module 0x8cdf6606cfc8b209386b96c036d2c3e554fff80e188d56ffdb12de547ba884cc::rkt {
    struct RKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKT>(arg0, 6, b"RKT", b"Sniper Rekt", b"Sniper RIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rkt_5d7ca8496a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

