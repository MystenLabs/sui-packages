module 0x39256030572b2f136834723bf50983adac58519eaf547428e4a6333b39f5bc73::shihsui {
    struct SHIHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIHSUI>(arg0, 6, b"ShihSui", b"Shih Sui", b"Shih Sui was no stranger to adventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_00_14_52_582ad6a260.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

