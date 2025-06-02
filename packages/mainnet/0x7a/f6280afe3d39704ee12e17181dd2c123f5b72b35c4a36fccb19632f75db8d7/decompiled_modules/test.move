module 0x7af6280afe3d39704ee12e17181dd2c123f5b72b35c4a36fccb19632f75db8d7::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 6, b"Test", b"DONT BUY TESTING ( Super League join tg for ofc launch )", b"Join telegram for ofc launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifz3wuykkraadpydzdgyvjmzlnoyjyy7y5yhvdix2tof33hnbfedy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

