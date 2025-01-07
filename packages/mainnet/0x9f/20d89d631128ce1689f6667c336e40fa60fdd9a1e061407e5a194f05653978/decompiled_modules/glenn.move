module 0x9f20d89d631128ce1689f6667c336e40fa60fdd9a1e061407e5a194f05653978::glenn {
    struct GLENN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLENN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLENN>(arg0, 6, b"GLENN", b"GLENN AI", b"Project GL-EN the very unique AI experiment that failed and turned against the SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/glenn_coin_b4977fa75a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLENN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLENN>>(v1);
    }

    // decompiled from Move bytecode v6
}

