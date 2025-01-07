module 0x99cb2ff07e957490194402b84453e791b2e0bc1a84cb37f9e9a08e0faa878429::splants {
    struct SPLANTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLANTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLANTS>(arg0, 6, b"SPlants", b"SuiPlants", x"46697273742022503245202b2054656c656772616d41707022206c61756e63686564206f6e206d6f766570756d702e636f6d2054686520546869726420576f726c642057617220666f726365642068756d616e69747920746f2067726f77206d7574616e7420706c616e747320746f20737572766976652e2053686f7720796f7572206e65696768626f72732077686f206861732074686520626573742067617264656e2157652077696c6c20696d6d6564696174656c79206d69677261746520746f20746865207375692065636f73797374656d20666f7220636f6e737472756374696f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q_Dm9aq_Hbb8_SM_Mu_Vgt4_Vg_YG_Ef_E_Cgvama_Co_Fu_HL_3_Qs_Faqv_08b5355e3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLANTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLANTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

