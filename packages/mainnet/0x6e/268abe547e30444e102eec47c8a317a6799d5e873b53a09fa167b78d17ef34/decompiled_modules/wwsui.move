module 0x6e268abe547e30444e102eec47c8a317a6799d5e873b53a09fa167b78d17ef34::wwsui {
    struct WWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWSUI>(arg0, 6, b"WWSui", b"WW3_on_Sui", b"Welcome to the next chapter if your life, full on war in the Middle East ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/46_A81_F7_E_AE_9_A_4210_9_E2_F_BA_8_FD_84_A63_EF_34504752d9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

