module 0x612d327efec1b52330e82cf7a2ebdc6cb6f35f48f2fc0fdd401efac01331b8ca::paca {
    struct PACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACA>(arg0, 6, b"PACA", b"ALPACA MONSTER", x"486527732064756d622c20646567656e2c20616e642070726f7564206f662069742e0a414c5041434120646f65736e74206f7665727468696e6b2c206865206a757374206a756d707320696e746f20746865206372617a696573742074726164657320776974686f75742061207365636f6e642074686f756768742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gi101000_1_1_0249c58015.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

