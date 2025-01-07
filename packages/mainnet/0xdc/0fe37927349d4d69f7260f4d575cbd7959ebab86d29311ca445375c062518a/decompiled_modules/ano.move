module 0xdc0fe37927349d4d69f7260f4d575cbd7959ebab86d29311ca445375c062518a::ano {
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

