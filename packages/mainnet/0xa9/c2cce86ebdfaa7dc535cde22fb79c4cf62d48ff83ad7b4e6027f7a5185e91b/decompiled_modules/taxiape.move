module 0xa9c2cce86ebdfaa7dc535cde22fb79c4cf62d48ff83ad7b4e6027f7a5185e91b::taxiape {
    struct TAXIAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXIAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAXIAPE>(arg0, 6, b"Taxiape", b"taxiape", x"57686f206e656564732061207461786920746f20746865206d6f6f6e3f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QYHD_Cqv_Td5um_P_Kam_M2_RG_5d_Da_Niqf_R_Atrvo_Horjisiy1n_47ac0f2ffa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXIAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAXIAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

