module 0x83c657106f75329778a952e45aba2fb5e73905d8d559b4bad5d06a1bf289d265::mdkp {
    struct MDKP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDKP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDKP>(arg0, 6, b"MDKP", b"Mudkiponsui", x"437574657374204d75646b6970206973206c61756e6368206f6e202353756920626c7570707020626c7570707020f09faba7f09faba720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955744349.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDKP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDKP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

