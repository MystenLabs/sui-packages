module 0x8a9c42d9b234f05fd6776f05c8a61c811ab1b7afa2ece56c3ae1d2250fb426e0::wwsuiii {
    struct WWSUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWSUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWSUIII>(arg0, 6, b"WWsuIII", b"World war III", b"Amen!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/46_A81_F7_E_AE_9_A_4210_9_E2_F_BA_8_FD_84_A63_EF_d3bee05f12.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWSUIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWSUIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

