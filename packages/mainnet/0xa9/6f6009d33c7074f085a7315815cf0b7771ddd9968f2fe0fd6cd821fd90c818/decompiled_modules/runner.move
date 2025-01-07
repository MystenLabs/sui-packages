module 0xa96f6009d33c7074f085a7315815cf0b7771ddd9968f2fe0fd6cd821fd90c818::runner {
    struct RUNNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNNER>(arg0, 6, b"RUNNER", b"Love Running", b"We love to run. Period. Full stop.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RUNNER_77dba66d38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUNNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

