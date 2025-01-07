module 0x343464e84ebb33d65623de150405cbc11aa92e099782975adf26efbb8e8ac4c3::bloop {
    struct BLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOP>(arg0, 6, b"Bloop", b"BLOOP", b"Bloop, a revolutionary memecoin built on the SUI network. Inspired by the mysterious sound believed to come from a gigantic sea creature, Bloop symbolizes power, influence, and innovation in the world of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241024_123716_1cd141100c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

