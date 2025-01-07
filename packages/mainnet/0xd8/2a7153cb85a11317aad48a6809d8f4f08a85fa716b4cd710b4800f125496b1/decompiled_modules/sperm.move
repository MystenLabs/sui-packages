module 0xd82a7153cb85a11317aad48a6809d8f4f08a85fa716b4cd710b4800f125496b1::sperm {
    struct SPERM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPERM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPERM>(arg0, 6, b"SPERM", b"Sperm Whale", b"Meet $SPERM Whale, The biggest fish in the Sui sea!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_6e0336b398.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPERM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPERM>>(v1);
    }

    // decompiled from Move bytecode v6
}

