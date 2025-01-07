module 0x24847434d70089caea37f5c28288a8f1eda907fc685dc9dfabb1424ed28e913e::suingu {
    struct SUINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINGU>(arg0, 6, b"SUINGU", b"Suingu", b"Best Penguin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINGU_4d8254ecc8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

