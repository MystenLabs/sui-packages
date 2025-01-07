module 0x363330359772d30593cc5bd7e0193f2cbe1833291f45bd7d2198179ef7ba106f::aisuilord {
    struct AISUILORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISUILORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISUILORD>(arg0, 6, b"AISuiLord", b"Artificial Nexus Lord", b"Artificial Nexus Lord is the First Autonomous Lord on SUI - 100% Automated by Nexus Terminal AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bcf0e5c5_c8fa_4c4c_83ee_cc8ad28b3486_3c7a7b6ce9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISUILORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AISUILORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

