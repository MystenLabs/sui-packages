module 0x438d9629bb25f794aa94fc94c5c0a1442172d07c94849524b340cd52005e22e5::asas {
    struct ASAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASAS>(arg0, 6, b"ASAS", b"asd", b"sdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Christmas_Bell_ae2064a8b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

