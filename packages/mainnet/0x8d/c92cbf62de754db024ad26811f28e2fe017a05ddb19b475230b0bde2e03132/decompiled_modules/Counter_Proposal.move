module 0x8dc92cbf62de754db024ad26811f28e2fe017a05ddb19b475230b0bde2e03132::Counter_Proposal {
    struct COUNTER_PROPOSAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUNTER_PROPOSAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUNTER_PROPOSAL>(arg0, 9, b"COUNTER", b"Counter Proposal", b"just counter them. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0MLtxKbQAA_WSs?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COUNTER_PROPOSAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUNTER_PROPOSAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

