module 0xdd7d3536cecc59b2be9cd4b4350ce01f8de10955017c624dc5046f5efc8aacc3::smumu {
    struct SMUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUMU>(arg0, 6, b"SMUMU", b"SuiMumu", b"Sui Mumu is a decentralized cryptocurrency powered by a strong community of bulls, represented by MUMU, the bull market`s mascot. Mumu has dominated and controlled market sentiments in the past and returned in the Spring of 2023.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_83335ff791.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

