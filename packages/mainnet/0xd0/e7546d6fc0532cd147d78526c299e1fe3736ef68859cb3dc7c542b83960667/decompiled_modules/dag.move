module 0xd0e7546d6fc0532cd147d78526c299e1fe3736ef68859cb3dc7c542b83960667::dag {
    struct DAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAG>(arg0, 6, b"Dag", b"DagSUI", b"Am I Irish Gypsy? Am I Bostonian? I am Dag. Do you like Dags?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qbgf6w4_Ja6_Vu_Wus6_R_Fhtwqr_Mr4_L_Dfb6kka_Xqdj_PL_8_U8j_1f9690e709.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

