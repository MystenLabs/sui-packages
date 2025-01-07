module 0xe1005566c0590d6f2c1c12bdc01d2cf3df8fec915e8705019f4c702a07b9338e::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SUIP", b"SUI PANDA", b"Panda is on Sui blockchain. Pandas are funny. They like eating bamboo and sweet food. They spend most of time eating and sleeping. They are good at climbing to reach the highs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/panda_7802897a0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

