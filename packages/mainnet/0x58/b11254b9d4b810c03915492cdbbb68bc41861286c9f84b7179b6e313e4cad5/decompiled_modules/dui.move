module 0x58b11254b9d4b810c03915492cdbbb68bc41861286c9f84b7179b6e313e4cad5::dui {
    struct DUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUI>(arg0, 6, b"DUI", b"Dui blames dog", b"The dog does not face any charges and was let go with just a warning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F_Hq_Rdk7ac_A_Qn_Co_Y_31d7f889c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

