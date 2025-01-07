module 0xef55e8bd926b7780fc4287e9cd750e0962a5de9a923070b710f22d75811ceeb4::wishers {
    struct WISHERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISHERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WISHERS>(arg0, 6, b"Wishers", b"SWSH", b"You know what it is - only the finest for the SUI family. Spark up a Sui Wisher and watch the green candles burn. SWSH!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D8292_FBE_657_E_4_D8_F_93_C7_62_F2_AC_5_D22_C2_627b73b3a7.WEBP")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISHERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WISHERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

