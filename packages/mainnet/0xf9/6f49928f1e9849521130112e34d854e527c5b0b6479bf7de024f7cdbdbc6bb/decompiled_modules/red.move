module 0xf96f49928f1e9849521130112e34d854e527c5b0b6479bf7de024f7cdbdbc6bb::red {
    struct RED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED>(arg0, 9, b"RED", b"Red Bangkok", b"Red Bangkok on red ocean god ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/767be15256781e03e980717709935f6ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

