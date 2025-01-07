module 0xe6ca82855cca9e64620daf56615ae88700fb2255230dd16aec0e93416e5d875a::blubler {
    struct BLUBLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBLER>(arg0, 6, b"Blubler", b"BLUBLER", b"blubler is blubler.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deploy_b2577e0e26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

