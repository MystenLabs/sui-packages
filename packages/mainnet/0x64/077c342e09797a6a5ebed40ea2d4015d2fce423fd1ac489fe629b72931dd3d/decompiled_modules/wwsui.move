module 0x64077c342e09797a6a5ebed40ea2d4015d2fce423fd1ac489fe629b72931dd3d::wwsui {
    struct WWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWSUI>(arg0, 6, b"WWSui", b"World War on Sui", b"The world is going full retard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/46_A81_F7_E_AE_9_A_4210_9_E2_F_BA_8_FD_84_A63_EF_d3bee05f12.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

