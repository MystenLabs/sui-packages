module 0x6ca7d850edb5cea72746a702eb2b68c79e39087f38148373d850f25cce57895e::pearl {
    struct PEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARL>(arg0, 6, b"PEARL", b"Pearl Krabs", b"The pearl the SUI ocean didnt know it needed! Shining brighter than Mr. Krabs' shell and worth more than a teenage whale at the mall! Grab your $PEARL and ride the profit waves before it becomes a deep-sea legend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/We_are_live_at_Movepump_7_5257882c94.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

