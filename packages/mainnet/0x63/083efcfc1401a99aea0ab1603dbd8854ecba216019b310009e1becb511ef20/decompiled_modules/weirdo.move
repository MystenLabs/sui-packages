module 0x63083efcfc1401a99aea0ab1603dbd8854ecba216019b310009e1becb511ef20::weirdo {
    struct WEIRDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEIRDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEIRDO>(arg0, 6, b"WEIRDO", b"Weirdo", b"Uniting weirdos worldwide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_I1_G_Ho_TP_400x400_26641d44bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEIRDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEIRDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

