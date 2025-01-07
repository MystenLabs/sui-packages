module 0x87ec3ec3d19e7e6c529e7f9d79e16153e0143594d27f5cdfad503b3e400e3643::chaos {
    struct CHAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAOS>(arg0, 6, b"Chaos", b"Chaos cat", b"Complete disorder and confusion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chaos_61fdaff2b3.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

