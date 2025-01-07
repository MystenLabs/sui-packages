module 0xfcbc5aaa7b483c669ab1e24841f6dce02d03c8ee82177d94ddf98796fad254aa::ping {
    struct PING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PING>(arg0, 9, b"PING", b"PING", b"PING TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cny.pga.com/wp-content/uploads/sites/4/2022/02/ping-logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PING>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PING>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PING>>(v1);
    }

    // decompiled from Move bytecode v6
}

