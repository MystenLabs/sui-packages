module 0xa766e90a18ef121eb63e0464c910a6ccb31b17844a3982375078725a22332242::fofar {
    struct FOFAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOFAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOFAR>(arg0, 6, b"FOFAR", b"Official Fofar Gaming", b"Official Fofar Gaming.Website: https://www.fofarsui.fun Telegram:https://t.me/FofarGamingSui X:https://x.com/fofar_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_16_b0ef3cc0a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOFAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOFAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

