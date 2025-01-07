module 0x949445013be5c7f508c023936a7020c1702297f4ed925d28ee17ab25df106ab8::octowif {
    struct OCTOWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOWIF>(arg0, 6, b"OCTOWIF", b"OctoWif", b"October is the month of OCTO - the cutest little octopus on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_Ch_Xu_SS_4h11tm4_Lt9_BUS_57_JM_Nw_X3i_VV_Weus_NT_Cr7_V_Hn_Q_cf9f0938b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

