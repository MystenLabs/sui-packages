module 0x2b07d15ce4545f8473dd773b68ccbf5b3ee1161a0e4b773ab670471d023516::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 6, b"SHARK", b"Shark", b"cutest shark of the SUI sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_Shark_3edf720cda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

