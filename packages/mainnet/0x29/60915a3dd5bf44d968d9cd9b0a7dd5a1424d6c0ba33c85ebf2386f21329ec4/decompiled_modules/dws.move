module 0x2960915a3dd5bf44d968d9cd9b0a7dd5a1424d6c0ba33c85ebf2386f21329ec4::dws {
    struct DWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWS>(arg0, 6, b"DWS", b"DICKWIFSUI", b"Dickwifsui !!!!!!!!!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Jc_Zw_QG_Xg_A_Al8_D5_136a0fca71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

