module 0xfc0ffb3a733cf3a9cec8f38a4a05e6dfb0d6763b8cb613986342c5434a5ada8d::aida {
    struct AIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDA>(arg0, 6, b"AIDA", b"Agent Aida", b"The wait is over! Im agent AIDA, your guide to SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1295_9c88484490.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

