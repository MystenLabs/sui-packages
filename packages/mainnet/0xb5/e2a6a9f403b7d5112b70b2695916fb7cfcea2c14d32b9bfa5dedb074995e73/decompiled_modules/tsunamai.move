module 0xb5e2a6a9f403b7d5112b70b2695916fb7cfcea2c14d32b9bfa5dedb074995e73::tsunamai {
    struct TSUNAMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUNAMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TSUNAMAI>(arg0, 6, b"TSUNAMAI", b"TSUNAMAI", b"Tsunami, Non-AI AI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2024_12_28_23_14_19_A_realistic_depiction_of_a_massive_tsunami_wave_approaching_a_coastal_city_The_wave_is_towering_over_buildings_with_turbulent_water_and_foam_at_its_98e1c2db53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSUNAMAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUNAMAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

