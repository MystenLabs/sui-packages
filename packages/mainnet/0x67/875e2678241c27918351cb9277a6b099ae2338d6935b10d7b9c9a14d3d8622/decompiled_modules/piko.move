module 0x67875e2678241c27918351cb9277a6b099ae2338d6935b10d7b9c9a14d3d8622::piko {
    struct PIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKO>(arg0, 6, b"PIKO", b"PIKO SUI", b"Piko, a digital doggo born from code, wags his virtual tail in the Web3 world. This AI pup combines canine charm with blockchain smarts, fetching innovation with every byte.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FZ_2_Wo4_C_Rz1opufm7_JK_2_Jd_Ho_Fjj_FB_4k_Qwfw1k_WDQ_3pump_a6766cf177.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

