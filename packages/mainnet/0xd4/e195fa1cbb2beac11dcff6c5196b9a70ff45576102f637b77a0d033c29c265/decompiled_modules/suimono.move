module 0xd4e195fa1cbb2beac11dcff6c5196b9a70ff45576102f637b77a0d033c29c265::suimono {
    struct SUIMONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONO>(arg0, 6, b"SUIMONO", b"SUI MONO", b"SUIMONO = SOUP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimono_e76de29638.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

