module 0x292f50bda12c3750be91c059cc79bf6ec2b7c02c3dfef9e8fdaddca11ac5b97d::ubi {
    struct UBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBI>(arg0, 6, b"UBI", b"Universal Basic Income", b"Literally free money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_19_10_50_13_A_futuristic_cityscape_with_vibrant_technology_showing_people_receiving_digital_payments_symbolized_by_glowing_cryptocurrency_coins_Blockchain_symbo_caa0d1ea89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

