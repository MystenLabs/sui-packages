module 0x82533d9ee3a918f9deb3e8a1bd045460ebbc5b7a781ecfbe8e24e7a504670a91::fatbearsui {
    struct FATBEARSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATBEARSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATBEARSUI>(arg0, 6, b"FatBearSui", b"Fat Bear Sui", b"Fat Bear Sui  Week begins after contestant's fatal river mauling.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_a_ae_a_c_e_2024_10_03_162337_e04bb1310c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATBEARSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATBEARSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

