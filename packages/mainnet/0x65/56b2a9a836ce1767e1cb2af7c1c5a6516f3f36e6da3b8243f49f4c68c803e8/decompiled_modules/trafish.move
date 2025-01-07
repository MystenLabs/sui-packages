module 0x6556b2a9a836ce1767e1cb2af7c1c5a6516f3f36e6da3b8243f49f4c68c803e8::trafish {
    struct TRAFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAFISH>(arg0, 6, b"TRAFISH", b"TraFish Scott", x"5377696d6d696e6720696e2074686520646565702c20796561682c20496d206665656c696e67206c696b6520746865206b696e672c0a427562626c657320616c6c2061726f756e64206d652c20496d2074686520666973682077686f20676f742074686520626c696e672c0a466c697070696e207468726f756768207468652077617665732c2061696e74206e6f206e65656420666f7220616e79206c616e642c0a496e2074686520636f72616c20726565662c204920676f742074686520776f726c6420696e206d792066696e732c206d616e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artworks_h4w_TG_5_Zjy_Q_Sz_Ju5y_VPX_Dww_t500x500_e354e6dbef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

