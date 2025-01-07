module 0x1611554cbc5885e6363b1df0c2e9f11fa2395318a860454f11024ffae39c396e::suita {
    struct SUITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITA>(arg0, 6, b"SUITA", b"SUITA: SUI POCHITA", b"SUITA IS THE ONLY ONE TO SEND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_depict_Baltse_a_doge_with_a_distinctive_short_2_7c6d85a2a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

