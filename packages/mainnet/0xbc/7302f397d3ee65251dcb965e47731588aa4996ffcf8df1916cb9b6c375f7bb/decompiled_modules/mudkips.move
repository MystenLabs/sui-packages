module 0xbc7302f397d3ee65251dcb965e47731588aa4996ffcf8df1916cb9b6c375f7bb::mudkips {
    struct MUDKIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDKIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDKIPS>(arg0, 6, b"Mudkips", b"Mudkiponsui", x"437574657374204d75646b6970206973206c61756e6368206f6e202353756920626c7570707020626c7570707020f09faba7f09faba720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994344839.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDKIPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDKIPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

