module 0x757469a6e4f85aec7942c6962607b3132e09c39db49b5b1ccd17e9cc2c6b67cd::jay {
    struct JAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAY>(arg0, 6, b"Jay", b"Jarry", x"612063757465207261626269742e0a486973206e616d65206973204a617272792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730590798923.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

