module 0x61c919e8c594352731b0e0aecfe781afa0a0da0c8530fb7821e47ef95da8b1bf::rug {
    struct RUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUG>(arg0, 6, b"RUG", b"HOP.RUG", b"Phase 47 has been confirmed for 2038", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000951915_a3c677e100.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

