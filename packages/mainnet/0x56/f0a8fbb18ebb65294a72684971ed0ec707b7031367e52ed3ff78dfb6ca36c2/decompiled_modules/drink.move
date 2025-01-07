module 0x56f0a8fbb18ebb65294a72684971ed0ec707b7031367e52ed3ff78dfb6ca36c2::drink {
    struct DRINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRINK>(arg0, 6, b"DRINK", b"DRINKIES", b"$DRINK -  already here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ges_KCU_XMA_Ev3_EY_186ebc49d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

