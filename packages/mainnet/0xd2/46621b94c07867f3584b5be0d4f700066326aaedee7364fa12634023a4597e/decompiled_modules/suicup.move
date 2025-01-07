module 0xd246621b94c07867f3584b5be0d4f700066326aaedee7364fa12634023a4597e::suicup {
    struct SUICUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUP>(arg0, 6, b"SuiCup", b"CupSui", b"SuiCup: No chop sui! Fill your cup with Sui profits. Write SUI on any cup, post it, and join the global meme movement on the Sui blockchain! #SuiCup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/69469_AB_0_5_F3_E_4_AE_2_87_BD_FCC_43_A043_FA_0_42b3a0c4a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

