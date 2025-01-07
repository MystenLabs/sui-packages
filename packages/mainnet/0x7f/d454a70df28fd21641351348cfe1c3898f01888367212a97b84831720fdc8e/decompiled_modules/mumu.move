module 0x7fd454a70df28fd21641351348cfe1c3898f01888367212a97b84831720fdc8e::mumu {
    struct MUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMU>(arg0, 6, b"MUMU", b"SuiMumu", b"Sui Mumu is a decentralized cryptocurrency powered by a strong community of bulls, represented by MUMU, the bull market`s mascot. Mumu has dominated and controlled market sentiments in the past and returned in the Spring of 2023.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000187_dcecfb06ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

