module 0x3914526022f62d38fa2334b3b0bfb600a02e408c9241ba3bc5c0d85081b27a6e::trust {
    struct TRUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUST>(arg0, 9, b"TRUST", b"TRUST ME BRO", b"source: trust me bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3b2e21546f0fa57dd90ffaecf6c46232blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

