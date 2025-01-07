module 0x2985863206d877840ea9f6182e2462f234d976ddb963a74360f32ebfaa8dc97f::text {
    struct TEXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEXT>(arg0, 9, b"text", b"textcoin", b"text coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWkEm39BXET79qsZx77DEoJEXgFCm9QQPwuoj4wAiB6Se")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEXT>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEXT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEXT>>(v1);
    }

    // decompiled from Move bytecode v6
}

