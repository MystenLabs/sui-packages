module 0x6b00304bd53ceee694ed42de4637f6508714d9b2f4f35131e3d3e2ea08092b40::piko {
    struct PIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKO>(arg0, 6, b"PIKO", b"PIKSUI", b"AI's goodest boy | Chief doggo of $PIKO | Fetch rate 99.69%", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FZ_2_Wo4_C_Rz1opufm7_JK_2_Jd_Ho_Fjj_FB_4k_Qwfw1k_WDQ_3pump_a49824dcee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

