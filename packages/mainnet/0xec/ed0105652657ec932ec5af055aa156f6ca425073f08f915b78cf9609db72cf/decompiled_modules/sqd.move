module 0xeced0105652657ec932ec5af055aa156f6ca425073f08f915b78cf9609db72cf::sqd {
    struct SQD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQD>(arg0, 6, b"SQD", b"SqUId", b"A Squid in the SUI World. Let's Create Together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/th_3641310320_9cea5e5029.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQD>>(v1);
    }

    // decompiled from Move bytecode v6
}

