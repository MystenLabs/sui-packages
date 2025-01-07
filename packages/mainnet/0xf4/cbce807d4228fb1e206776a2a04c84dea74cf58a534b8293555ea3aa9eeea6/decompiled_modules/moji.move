module 0xf4cbce807d4228fb1e206776a2a04c84dea74cf58a534b8293555ea3aa9eeea6::moji {
    struct MOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJI>(arg0, 6, b"MOJI", b"Mojicat", b"Moji - cute yellow furry cat! Moji was a huge inspiration for us to create $Moji. This super cute cat is agile, cunning and intelligent! The $Moji project hopes to receive recognition from everyone. We have a clear plan and need a little help from the community. Stay calm with faith in $Moji and we will do the rest for you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_WVK_Jf_G_Kr5_Rq6w3y9o_UL_1_Fwe_G4t3_Nf8_C3qs2i8u_Ud_Vm9r_1_33bd0bb878.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

