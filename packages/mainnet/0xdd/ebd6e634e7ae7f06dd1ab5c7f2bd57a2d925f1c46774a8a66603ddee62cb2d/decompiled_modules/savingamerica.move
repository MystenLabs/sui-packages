module 0xddebd6e634e7ae7f06dd1ab5c7f2bd57a2d925f1c46774a8a66603ddee62cb2d::savingamerica {
    struct SAVINGAMERICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVINGAMERICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVINGAMERICA>(arg0, 6, b"SAVINGAMERICA", b"ElonMagaTeslaGrok", b"GET IN LOSER, WE'RE SAVING AMERICA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_Ya_YA_4_WQAA_8_W3_V_072563fcbf.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVINGAMERICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVINGAMERICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

