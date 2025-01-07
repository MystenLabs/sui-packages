module 0xce0f77e1d7e413e076cbad978b1d02e61ba4951b1bc9f6a325c06fce1fa35bd0::gargamel {
    struct GARGAMEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARGAMEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARGAMEL>(arg0, 6, b"GARGAMEL", b"Kont Gargamela", b"The Kont is back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_A3_D7_E91_2057_4468_92_C9_7_C3730_D048_A4_5d29f6b38b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARGAMEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARGAMEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

