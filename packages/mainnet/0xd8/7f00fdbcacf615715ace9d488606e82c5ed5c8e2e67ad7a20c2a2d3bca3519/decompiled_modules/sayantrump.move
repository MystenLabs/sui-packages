module 0xd87f00fdbcacf615715ace9d488606e82c5ed5c8e2e67ad7a20c2a2d3bca3519::sayantrump {
    struct SAYANTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAYANTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAYANTRUMP>(arg0, 6, b"SAYANTRUMP", b"Suiper Sayan Trump", b"Suiper Sayan Trump. Evolved Super Trump. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031303_c08cc472fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAYANTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAYANTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

