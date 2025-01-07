module 0xfc616cc4ad632b4459dbb920b1afc20ac7eb9d920da1fa5315d77b165219dae2::laugh {
    struct LAUGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUGH>(arg0, 6, b"LAUGH", b"Laughcoin", b"LaughCoin est conu pour clbrer lhumour et les rires. Chaque token reprsente un moment de joie et de bonne humeur, parfait pour ceux qui aiment les blagues et les mmes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Laughcoin_196c0ff054.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAUGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

