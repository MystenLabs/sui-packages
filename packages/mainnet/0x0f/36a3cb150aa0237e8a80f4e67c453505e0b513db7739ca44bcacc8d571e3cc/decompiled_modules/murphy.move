module 0xf36a3cb150aa0237e8a80f4e67c453505e0b513db7739ca44bcacc8d571e3cc::murphy {
    struct MURPHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURPHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURPHY>(arg0, 6, b"MURPHY", b"MURPHY MEME", b"Keeping my nephew Cheems sane and bullish in these choppy market conditions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KSK_Sgi_Jb_400x400_c50d48d173.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURPHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURPHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

