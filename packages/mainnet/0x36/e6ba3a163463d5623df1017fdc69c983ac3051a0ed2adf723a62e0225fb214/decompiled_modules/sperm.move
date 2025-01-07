module 0x36e6ba3a163463d5623df1017fdc69c983ac3051a0ed2adf723a62e0225fb214::sperm {
    struct SPERM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPERM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPERM>(arg0, 6, b"SPERM", b"Sperm Whale", b"Meet Sperm Whale.  $SPERM is here to fertilize your bags with unstoppable growth. Swim with the biggest fish in Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_21_d29d8db128.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPERM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPERM>>(v1);
    }

    // decompiled from Move bytecode v6
}

