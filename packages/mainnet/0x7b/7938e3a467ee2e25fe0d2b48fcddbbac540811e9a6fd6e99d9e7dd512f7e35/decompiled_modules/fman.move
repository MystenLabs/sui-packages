module 0x7b7938e3a467ee2e25fe0d2b48fcddbbac540811e9a6fd6e99d9e7dd512f7e35::fman {
    struct FMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMAN>(arg0, 6, b"FMAN", b"Florida Man", b"$Blub Billionaire Maxi On $Sui doing crazy things daily.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F6_AA_42_B4_88_E8_4_A2_B_A4_BD_6_FC_0_E4480_A94_1cedaa655d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

