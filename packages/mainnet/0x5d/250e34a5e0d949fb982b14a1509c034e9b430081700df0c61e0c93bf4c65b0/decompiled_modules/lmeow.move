module 0x5d250e34a5e0d949fb982b14a1509c034e9b430081700df0c61e0c93bf4c65b0::lmeow {
    struct LMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMEOW>(arg0, 6, b"LMEOW", b"LMEOW on SUI", b"Based cat coin on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n6b_GU_Ptd_400x400_7807a458f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

