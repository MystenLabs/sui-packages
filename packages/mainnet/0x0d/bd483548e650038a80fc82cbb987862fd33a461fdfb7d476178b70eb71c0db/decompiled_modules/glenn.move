module 0xdbd483548e650038a80fc82cbb987862fd33a461fdfb7d476178b70eb71c0db::glenn {
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

