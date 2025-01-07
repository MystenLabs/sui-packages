module 0x80356d70fd0090c0b38a8da4716b21c119309665120b5732323053474673f497::mdkps {
    struct MDKPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDKPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDKPS>(arg0, 6, b"MDKPS", b"MudkipS", x"437574657374204d75646b6970206973206c61756e6368206f6e202353756920626c7570707020626c7570707020f09faba7f09faba720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994156708.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDKPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDKPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

