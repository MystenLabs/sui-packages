module 0x340d7543ca978a62c03be1e203c727f7e580c0e78f6db4f6de40bd9e3422a0a7::aimerwreo {
    struct AIMERWREO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMERWREO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIMERWREO>(arg0, 6, b"AIMERWREO", b"Ai Agent Merwreo", x"6265702062657020626f7020626f70202d206172742f636f6e74656e742063726561746f72204167656e74204d65727772656f2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Yi_A4_Lsc_P3vgqk_Vqqi8qh8d_Uk6e_By_SR_6_Dr_Gu_Fsz_Fyi_Y4_797e49280c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMERWREO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIMERWREO>>(v1);
    }

    // decompiled from Move bytecode v6
}

