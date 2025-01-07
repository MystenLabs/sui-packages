module 0xe68bd0ba3edd9c474446b5c344bd65e779daff40228fe74e813c11a47d2efdcc::rtrd {
    struct RTRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTRD>(arg0, 6, b"RTRD", b"Retardeng", b"Bringing the solana narrative of retardio and moo deng to $SUI ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000093_a19422fd63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

