module 0xab933c957dca4f9e7882bdcef09513a3af0e22760e7539abcae4f265a1df4e2e::jjjs {
    struct JJJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJJS>(arg0, 9, b"JJJS", b"Nka", b"Jja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40ec958d-f7d3-4422-bc70-92b8da0ccd7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

