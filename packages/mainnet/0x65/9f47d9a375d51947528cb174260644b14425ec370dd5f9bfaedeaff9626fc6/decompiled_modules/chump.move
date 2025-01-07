module 0x659f47d9a375d51947528cb174260644b14425ec370dd5f9bfaedeaff9626fc6::chump {
    struct CHUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHUMP>(arg0, 6, b"CHUMP", b"Chump The Chimp", b"Chump brings wisdom and humour to the $Sui block chain. Ai agent token and NFT peoject. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004481_27361ce04b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

