module 0x2dcb716addeda0fe657994924014a6025887319e925420839051179f9174b9c1::seadogsui {
    struct SEADOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEADOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEADOGSUI>(arg0, 6, b"SEADOGSUI", b"SEADOG THE SAILOR", b"IT'S A FUCKING SENDOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_17_48_05_f4b1805dd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEADOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEADOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

