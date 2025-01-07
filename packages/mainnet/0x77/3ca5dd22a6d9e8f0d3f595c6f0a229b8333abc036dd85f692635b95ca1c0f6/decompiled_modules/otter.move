module 0x773ca5dd22a6d9e8f0d3f595c6f0a229b8333abc036dd85f692635b95ca1c0f6::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTER>(arg0, 6, b"Otter", b"Otter Token", b"Otter Coin is a digital currency specifically designed for sustainability and environmental projects, inspired by otterssmart, cooperative animals that live in harmony with their environment. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_10_12_04_48_A_digital_cryptocurrency_coin_called_Otter_featuring_an_elegant_design_with_a_sleek_otter_in_the_center_The_coin_has_a_nature_inspired_theme_with_6d3355f3ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

