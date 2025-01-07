module 0xf7aeae4b40d47c64a0bd5b16ccc46621869b05c18b90aeaeaf29e8ba37859326::m3m3s {
    struct M3M3S has drop {
        dummy_field: bool,
    }

    fun init(arg0: M3M3S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M3M3S>(arg0, 6, b"M3M3S", b"M3M3SUI", b"Like $M3M3 but on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733436137216.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M3M3S>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M3M3S>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

