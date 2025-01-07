module 0x862e2ac098ce7450671cf2fdd339963413e4fd2bf4a209b7d07588921ed40438::ron {
    struct RON has drop {
        dummy_field: bool,
    }

    fun init(arg0: RON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RON>(arg0, 9, b"RON", b"DRONE", b"Drone is a governance coin of dwindle labs. Dwindle labs is the venture and incubation arm of dwindle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RON>(&mut v2, 25000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RON>>(v1);
    }

    // decompiled from Move bytecode v6
}

