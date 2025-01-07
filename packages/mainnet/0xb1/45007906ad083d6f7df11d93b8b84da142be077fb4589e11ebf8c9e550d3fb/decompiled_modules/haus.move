module 0xb145007906ad083d6f7df11d93b8b84da142be077fb4589e11ebf8c9e550d3fb::haus {
    struct HAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAUS>(arg0, 6, b"HAUS", b"COIN HAUS", b"This is COIN HAUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_972c1c1157.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

