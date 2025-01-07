module 0xfb935e0ef8cb76d207ad2cdfe15bca9130e90d783f5d5dd51a865551655c48ba::zacarxcoin {
    struct ZACARXCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZACARXCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZACARXCOIN>(arg0, 8, b"ZACARXCOIN", b"zacarxcoin", b"we love zacarx'coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/3om0zV4j9AHvC5KSrcg3iyMU8zOavKhg3uT8q1rwap0")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZACARXCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZACARXCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

