module 0x74298025e94909b09e8494cb63279ea57c6c5c760d475f230f092b5141430bfa::airborne {
    struct AIRBORNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRBORNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRBORNE>(arg0, 6, b"AIRBORNE", b"AIrborn", b"Transforming brands through strategy, design & tech | We guide our partners to lead change, not be led by it | #LeadTheChange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1212_e7b5bd04ee.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRBORNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRBORNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

