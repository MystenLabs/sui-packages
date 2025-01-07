module 0xf61184b513f9b8e8277485a424407ac6f7b9438e3b59f3b9012f4565ce986d34::d06 {
    struct D06 has drop {
        dummy_field: bool,
    }

    fun init(arg0: D06, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D06>(arg0, 6, b"D06", b"1337 d06", b"7h3 d06 15 c0d3d. Leet (or \"1337\"), also known as eleet or leetspeak, or simply hacker speech, is a system of modified spellings used primarily on the Internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pb_RK_2_Ldmq_Qaky_Pka_Ae_Rhq5vw_Jveuo_Bc2hf_Uvkh_Wn_Ltjf_b04c0ce698.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D06>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<D06>>(v1);
    }

    // decompiled from Move bytecode v6
}

