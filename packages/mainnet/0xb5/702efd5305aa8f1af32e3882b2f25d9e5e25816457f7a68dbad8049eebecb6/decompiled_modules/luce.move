module 0xb5702efd5305aa8f1af32e3882b2f25d9e5e25816457f7a68dbad8049eebecb6::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 6, b"LUCE", b"Official Mascot of the Holy Year", b"The Vatican unveils Luce (Italian for Light), the mascot for the Holy Year 2025. Dressed as a pilgrim with a yellow raincoat, worn boots, a missionary cross, and a pilgrim's staff, Luces eyes are filled with scallop shellsa symbol of hope.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Bd_Cx_Ko9_Qav_R9hf_Shgp_EBG_3zekor_Ae_D7_W1jfq2o3pump_4ffcffa204.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

