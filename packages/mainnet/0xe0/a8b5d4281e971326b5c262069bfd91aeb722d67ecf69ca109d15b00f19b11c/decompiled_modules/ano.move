module 0xe0a8b5d4281e971326b5c262069bfd91aeb722d67ecf69ca109d15b00f19b11c::ano {
    struct ANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANO>(arg0, 6, b"ANO", b"Anomalocaris", b"Earth's first predator, Anomalocaris ON Sui community first. .... will do my best XD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/istockphoto_1400327312_612x612_b512cbbd47.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANO>>(v1);
    }

    // decompiled from Move bytecode v6
}

