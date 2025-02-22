module 0x53d366b87e05116100b37559924cc5c2cdc5b674b20fd64ca35ac8feb6bc4718::csp {
    struct CSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSP>(arg0, 6, b"CSP", b"Chop sui panda", b"Chop, Earn, Compete, Repeat | Play now and join the movement  powered by $SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067054_02e5323aea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

