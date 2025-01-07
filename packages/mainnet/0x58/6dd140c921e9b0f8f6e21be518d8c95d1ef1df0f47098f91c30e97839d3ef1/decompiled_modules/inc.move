module 0x586dd140c921e9b0f8f6e21be518d8c95d1ef1df0f47098f91c30e97839d3ef1::inc {
    struct INC has drop {
        dummy_field: bool,
    }

    fun init(arg0: INC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INC>(arg0, 6, b"INC", b"Sui Incubator", x"53756920496e63756261746f722024494e43204d454d45204c61756e636820696e204475626169206279200a407375696e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_21_21_22_30_A_futuristic_digital_image_of_the_SUI_Network_logo_in_full_HD_quality_The_logo_is_a_drop_of_liquid_inside_a_circular_icon_with_a_blue_and_white_colo_fa9ef6c5ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INC>>(v1);
    }

    // decompiled from Move bytecode v6
}

