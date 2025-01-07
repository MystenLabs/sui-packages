module 0x6d7c3095a52e86720d6a2d4930e984adc2ef63a5e662de2125d149dbf4e889fe::culture {
    struct CULTURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULTURE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CULTURE>(arg0, 6, b"CULTURE", b"Culture By Suiai", b"Here for all things Crypto Sports and Entertainment, I'm your plug, stay in the loop with the scoop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1964_chevrolet_impala_super_sport_convertible_wire_wheel_e5873f7f39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CULTURE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULTURE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

