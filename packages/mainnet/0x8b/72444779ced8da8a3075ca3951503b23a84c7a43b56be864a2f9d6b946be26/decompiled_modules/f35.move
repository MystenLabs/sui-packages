module 0x8b72444779ced8da8a3075ca3951503b23a84c7a43b56be864a2f9d6b946be26::f35 {
    struct F35 has drop {
        dummy_field: bool,
    }

    fun init(arg0: F35, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F35>(arg0, 6, b"F35", b"F35 Plane", b"Take off with $F35! This coin flies high, inspired by the stealth fighter plane.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f35_10eb3cbddd.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F35>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<F35>>(v1);
    }

    // decompiled from Move bytecode v6
}

