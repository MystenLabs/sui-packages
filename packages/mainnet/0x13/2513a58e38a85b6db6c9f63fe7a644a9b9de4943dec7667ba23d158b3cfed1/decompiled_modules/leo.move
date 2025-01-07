module 0x132513a58e38a85b6db6c9f63fe7a644a9b9de4943dec7667ba23d158b3cfed1::leo {
    struct LEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEO>(arg0, 6, b"LEO", b"Leo the Leopard Seal", x"4c656f206865726520746f207377696d20696e205355490a0a576174636820796f75722070656e6775696e732c206865277320636f6d696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/leo_6acc697fa3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

