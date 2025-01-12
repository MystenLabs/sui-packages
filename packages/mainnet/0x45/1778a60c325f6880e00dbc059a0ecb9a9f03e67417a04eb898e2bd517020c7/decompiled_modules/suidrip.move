module 0x451778a60c325f6880e00dbc059a0ecb9a9f03e67417a04eb898e2bd517020c7::suidrip {
    struct SUIDRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRIP>(arg0, 6, b"Suidrip", b"SUIDRIP", b"SuiDrip is a decentralized staking reward platform built on the Sui blockchain. Designed to incentivize long-term participation, SuiDrip allows users to stake tokens and earn rewards after a defined bond period.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_12_21_52_54_f02d99fb3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

