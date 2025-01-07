module 0xe023627118f4b67fc793d3ffc08024b6ff63d266bc008d15f582ffa4819b1bcf::fsm {
    struct FSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSM>(arg0, 6, b"FSM", b"Flying Spaghetti Monster", b"The Flying Spaghetti Monster (FSM) is the deity of the Church of the Flying Spaghetti Monster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_06_132056_7ee4761c77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

