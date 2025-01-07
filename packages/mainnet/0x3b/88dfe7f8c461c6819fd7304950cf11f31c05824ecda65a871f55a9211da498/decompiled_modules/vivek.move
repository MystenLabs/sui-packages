module 0x3b88dfe7f8c461c6819fd7304950cf11f31c05824ecda65a871f55a9211da498::vivek {
    struct VIVEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIVEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIVEK>(arg0, 6, b"VIVEK", b"Vivek on SUI", b"Head of D.O.G.E", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2v_WLG_Gld_400x400_469822b859.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIVEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIVEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

