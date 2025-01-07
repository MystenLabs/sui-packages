module 0x15707313c5bb78d4da301e5e76ea4241f0aee3fdd227835eab56b013c674024::bundy {
    struct BUNDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNDY>(arg0, 6, b"BUNDY", b"BUNDY!", b"In the realm of crypto degens, Bundy reigns supreme. His decisions are swift and bold, fueled by the adrenaline rush of fast supercars and the thrill of the crypto market. Where others see uncertainty, Bundy sees opportunity, fearlessly stomping into the World of Crypto with a conviction that inspires us all to Make it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcu_Hx_HGTU_2hgc_R7gmh_UD_1_Pt_N4y_Fm1_Mcvab81hf6_W3o_Z_Vx_07297c6f77.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

