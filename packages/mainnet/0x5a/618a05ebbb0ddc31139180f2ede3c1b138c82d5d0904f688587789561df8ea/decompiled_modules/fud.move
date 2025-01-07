module 0x5a618a05ebbb0ddc31139180f2ede3c1b138c82d5d0904f688587789561df8ea::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 6, b"FUD", b"FUD", b"Send it to Zero.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/q45IvZCPeBN8zHG21uzoO6sT0Zcc-r7aFF5U9VdlyJU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

