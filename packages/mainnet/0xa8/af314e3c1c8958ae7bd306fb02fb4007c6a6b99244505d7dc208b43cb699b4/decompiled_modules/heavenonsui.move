module 0xa8af314e3c1c8958ae7bd306fb02fb4007c6a6b99244505d7dc208b43cb699b4::heavenonsui {
    struct HEAVENONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAVENONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAVENONSUI>(arg0, 6, b"HEAVENONSUI", b"HEAVEN", b"$HEAVEN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Yg_L5okk_E5exs_T_Lzebt5_Hmt_K9_Ay2_H_Mr53i8ubm_VC_2e_BR_2c652aea9e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAVENONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEAVENONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

