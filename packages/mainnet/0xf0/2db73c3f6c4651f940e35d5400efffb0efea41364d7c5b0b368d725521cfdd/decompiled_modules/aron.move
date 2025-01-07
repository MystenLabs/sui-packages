module 0xf02db73c3f6c4651f940e35d5400efffb0efea41364d7c5b0b368d725521cfdd::aron {
    struct ARON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARON>(arg0, 6, b"ARON", b"Arons Vault", b"Arons Vault is a memecoin inspired by the journey of Aron and Toro Maximus. It represents the quest for financial freedom and the unity of the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_25_14_54_17_A_powerful_and_inspiring_image_of_Aron_and_Toro_Maximus_together_symbolizing_strength_and_unity_Aron_a_young_boy_aged_12_15_with_tousled_brown_hair_db831270fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARON>>(v1);
    }

    // decompiled from Move bytecode v6
}

