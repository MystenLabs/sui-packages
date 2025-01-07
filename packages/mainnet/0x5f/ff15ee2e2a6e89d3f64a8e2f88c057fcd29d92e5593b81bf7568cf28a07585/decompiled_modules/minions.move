module 0x5fff15ee2e2a6e89d3f64a8e2f88c057fcd29d92e5593b81bf7568cf28a07585::minions {
    struct MINIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIONS>(arg0, 6, b"MINIONS", b"MINIONS ON SUI", b"MINIONS is coming on SUI now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_minions_5deb805ad8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

