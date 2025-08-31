module 0xb72d5ccc1ee4800a14c5d8a3e0ed52e449c8283992bfa661cf45fe4e3b66f8f4::Monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 9, b"MKY", b"Monkey", b"just a monkey on-chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gzqg5Z6XEAAvkl-?format=png&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

