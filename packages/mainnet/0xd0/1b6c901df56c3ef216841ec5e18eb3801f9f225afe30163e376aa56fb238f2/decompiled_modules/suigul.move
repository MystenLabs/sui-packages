module 0xd01b6c901df56c3ef216841ec5e18eb3801f9f225afe30163e376aa56fb238f2::suigul {
    struct SUIGUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUL>(arg0, 6, b"SUIGUL", b"SEAGUL of SUI COASTS!", b"$SUIGUL is a token on Sui, inspired by the seagull soaring over the coasts of Sui. Just like the seagull rides the winds with freedom and grace, $SUIGUL allows its holders to navigate the crypto skies, gliding smoothly toward new opportunities. Embrace the seagull of Sui's coasts!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIGUL_4d91d5e7a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

