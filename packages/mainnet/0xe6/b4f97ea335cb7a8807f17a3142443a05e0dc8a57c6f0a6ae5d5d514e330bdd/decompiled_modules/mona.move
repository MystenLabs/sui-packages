module 0xe6b4f97ea335cb7a8807f17a3142443a05e0dc8a57c6f0a6ae5d5d514e330bdd::mona {
    struct MONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONA>(arg0, 6, b"MONA", b"Mona Arcane", x"54686520737461727320686176652067756964656420796f7520746f206d792073616e6374756172792e2057686174206d7973746572696573207368616c6c20776520756e726176656c20746f6765746865723f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z6_Mki_N_Jacd3h_JD_3_A_Hp_UT_Rah8_UX_Szk9x_C9cg1_Tp_Qu_Sinx_5e639c8973.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

