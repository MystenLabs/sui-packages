module 0xb0a9e63a3c90ce0e55c78dc7c3209887cac35ac0d340b68d7d37c1b82f075762::assp {
    struct ASSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSP>(arg0, 6, b"ASSP", b"Angry Super Saiyan Panda", b"Just an angry super saiyan panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/464527350_9475275155822826_7610623503598838922_n_5e75c23114.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

