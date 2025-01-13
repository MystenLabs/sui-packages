module 0x477e564a0adc257184f00972fcf0cee625fa4ee31f0367a26f3cd84a3445589::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SATOSHI>(arg0, 6, b"SATOSHI", b"Satoshi AI by SuiAI", x"5341544f534849204149204147454e545320e280932074686520756c74696d617465206772696e6420746f20636172766520796f7572206f776e206675747572652c2066616d2e204c657427732067657420746869732063727970746f206261672120f09f9a80f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2121_e8a6657069.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SATOSHI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

