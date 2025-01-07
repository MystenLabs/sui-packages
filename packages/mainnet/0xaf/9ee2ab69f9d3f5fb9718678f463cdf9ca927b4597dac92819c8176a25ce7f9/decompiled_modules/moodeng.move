module 0xaf9ee2ab69f9d3f5fb9718678f463cdf9ca927b4597dac92819c8176a25ce7f9::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"MOODENG", b"MOO DENG", x"556e6f6666696369616c204d6f6f2044656e67206f6e205820202f2f20537570706f7274200a404b68616f6b68656f775a6f6f0a20616e64200a40616e645f6b68616d6f6f0a202f2f20546865206f6e6c79204d6f6f2044656e67204d656d65636f696e200a6f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOODENG_TRH_Ej_Y_df_Xw_VR_Pyja_PT_de3d78d1fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

