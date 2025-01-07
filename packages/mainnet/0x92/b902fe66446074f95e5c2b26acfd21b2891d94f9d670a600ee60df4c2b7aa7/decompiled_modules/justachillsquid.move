module 0x92b902fe66446074f95e5c2b26acfd21b2891d94f9d670a600ee60df4c2b7aa7::justachillsquid {
    struct JUSTACHILLSQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTACHILLSQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTACHILLSQUID>(arg0, 6, b"Justachillsquid", b"Just a chill squid", b"Just a chill squid (Justachillsquid)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042035_e14510ac26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTACHILLSQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTACHILLSQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

