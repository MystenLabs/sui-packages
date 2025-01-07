module 0xed911adb78625fe22db6a24862534cc14d39b69315a295a87241a6c15e800796::dobe {
    struct DOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBE>(arg0, 6, b"Dobe", b"Dobe on Sui", b"Put me into the right place pls.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/543_AC_7_E46644_D51_F75_F4_B67_C73_AC_4172_1f361fef57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

