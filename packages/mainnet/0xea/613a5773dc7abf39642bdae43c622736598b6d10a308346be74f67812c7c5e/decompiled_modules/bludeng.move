module 0xea613a5773dc7abf39642bdae43c622736598b6d10a308346be74f67812c7c5e::bludeng {
    struct BLUDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUDENG>(arg0, 6, b"Bludeng", b"Blu Deng", b"The greatest hippo on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_C9_F5790_FAC_2_425_C_8_FAC_74_CF_4_B865229_da23b0cea8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

