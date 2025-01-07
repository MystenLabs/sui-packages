module 0xe1ce500016e7b8df280c477a31edf20781436bcaec2cc7ec0a2ed9f3e893b140::hopfun {
    struct HOPFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFUN>(arg0, 6, b"HOPFUN", b"Hopfun", b"Launch memecoinsd,buy new ones and chat with other degens all whilst staying on the beautiful Hop UI/UX.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_W2a_H6_WAA_Ac_TZ_e74814af2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

