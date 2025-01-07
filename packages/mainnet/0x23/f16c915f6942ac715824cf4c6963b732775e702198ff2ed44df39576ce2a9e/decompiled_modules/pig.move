module 0x23f16c915f6942ac715824cf4c6963b732775e702198ff2ed44df39576ce2a9e::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG>(arg0, 6, b"PIG", b"PIGS", b"he PIG Fanclub More than a club, Less than a cult. All bacon. For supporters of @the_spacepig a truly original character according to his mom (and an artist and worldbuilder of many mediums).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Spacepig_TECHEJ_S4_M5_Kkc_Lx9_IC_3c2db26d78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

