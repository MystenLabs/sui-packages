module 0x13a271e630b76f9aa08592baee9fe29ebd7ed1036c0ab278a71c80d1dcf58dc1::plnd {
    struct PLND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLND>(arg0, 9, b"PLND", b"PEACELAND", b"LAND OF PEACE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b37cdc67-2a0f-45f8-87f8-c273c992acee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLND>>(v1);
    }

    // decompiled from Move bytecode v6
}

