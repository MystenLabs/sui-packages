module 0x60fc5196582d695f46237236d117763444d2ba598bdc829c2bb8dbdd11c96e3::neura {
    struct NEURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEURA>(arg0, 6, b"NEURA", b"NeuraCoin", b"NEURA NETWORKS PRESENTS NEUROCOIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B1506_F8_E_2255_47_A3_BC_8_D_9_DF_31_DB_422_AB_b38e5dd19c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

