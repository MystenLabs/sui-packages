module 0x261e1abb75da838b1382fc39feaf1c8b2baf33c215a3b3d1d62a924ca45fdbeb::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 9, b"FUD", b"fuddies", b"FUD around and find out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/jM0PvXz")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUD>(&mut v2, 4200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

