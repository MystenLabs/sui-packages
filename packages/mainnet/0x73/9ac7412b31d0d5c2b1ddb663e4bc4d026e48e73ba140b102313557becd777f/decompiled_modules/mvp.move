module 0x739ac7412b31d0d5c2b1ddb663e4bc4d026e48e73ba140b102313557becd777f::mvp {
    struct MVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVP>(arg0, 9, b"MVP", b"MVP", b"Move to Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MVP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MVP>>(v1);
    }

    // decompiled from Move bytecode v6
}

